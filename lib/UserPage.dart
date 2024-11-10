import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Model/PersonDataModel.dart';
import 'Reposatory/PersonRepo.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage extends StatefulWidget{
  int ID;
  UserPage({required this.ID});
  @override
  State<UserPage> createState() {
   return UserPageState();
  }
  
}
bool _isLoading = true;
//to call person data
UsersData? personData;

class UserPageState extends State<UserPage> {
//to open link
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data here
  }

  final PersonRepo repository = PersonRepo();

  Future<void> fetchData() async {
    UsersData? result = await repository.fetchUserData(
        widget.ID);
    if (result != null) {
      setState(() {
        personData = result;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Person Data",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : buildUserCard(), // Call the new method
    );
  }

  Widget buildUserCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 6),
      child: buildContent(),
    );
  }

  Widget buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildUserImage(),
        SizedBox(height: 12),  // Spacing between image and text
        buildNameText(),
        buildEmailText(),
        Text(
          "Support Url : ",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 14, color: Colors.blue.shade900),
        ),
        GestureDetector(
          onTap: () {
            _launchURL(personData!.support!.url!);
          },
          child: Flexible(
            child: Text(
              personData!.support!.url!.substring(0, 32) + // First 32 characters
                  '\n' +
                  personData!.support!.url!.substring(32, 64) + // Next 32 characters
                  '\n' +
                  personData!.support!.url!.substring(64), // Remaining characters
              style: TextStyle(fontSize: 14, color: Colors.blue.shade600),
              maxLines: 3, // Set max lines to 3
              overflow: TextOverflow.ellipsis, // Ellipsis if text exceeds limit
            ),
          ),
        ),
        // Text(personData!.support!.text!,
        //     style: TextStyle(fontSize: 14, color: Colors.black)),
      ],
    );
  }

  Widget buildUserImage() {
    return Center(
      child: ClipOval(
        child: Image.network(
          personData!.data!.avatar!,
          width: 100,  // Adjusted size for better visibility
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Image.asset("assets/images/name.png", width: 100, height: 100),
        ),
      ),
    );
  }

  Widget buildNameText() {
    return Center(
      child: Text(
          '${personData!.data!.firstName!} ${personData!.data!.lastName!}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget buildEmailText() {
    return Center(
      child: Text(personData!.data!.email!,
          style: TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }

}
