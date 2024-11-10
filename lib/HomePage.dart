import 'package:flutter/material.dart';
import 'package:prefectioncompany/Model/PersonData.dart';
import 'package:prefectioncompany/Model/UserModel.dart';
import 'package:prefectioncompany/UserPage.dart';

import 'Reposatory/UserRepo.dart'; // Ensure this is correctly defined

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserData> userData = []; // Change to correct type
  bool _isLoading = true;
  final AllUsersData repository = AllUsersData();

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data here
  }

  Future<void> fetchData() async {
    UserModel? result = await repository.fetchData(); // Fetch data from repository
    if (result != null) {
      setState(() {
        userData = result.data; // Populate userData with fetched data
        _isLoading = false; // Update loading status
      });
    } else {
      setState(() {
        _isLoading = false; // Update loading status
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Users Data", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : buildUserList(),
    );
  }

  Widget buildUserList() {
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (context, index) {
        return buildUserCard(index);
      },
    );
  }

  Widget buildUserCard(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 6),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserPage(ID: userData[index].id)),

          );
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(0xFFF0F6FF),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 2)],
          ),
          child: buildContent(index),
        ),
      ),
    );
  }

  Widget buildContent(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 16, right: 5,bottom: 5),
      child: Row(
        children: [
          buildUserImage(index),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildNameText(index),
              buildPhoneText(index),

            ],
          ),
        ],
      ),
    );
  }

  Widget buildUserImage(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: ClipOval(
        child: Image.network(
          userData[index].avatar,
          width: 63,
          height: 63,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/name.png", width: 63, height: 63),
        ),
      ),
    );
  }

  Widget buildNameText(int index) {
    return Text(userData[index].firstName +' '+  userData[index].lastName , style: TextStyle(fontSize: 16));

  }

  Widget buildPhoneText(int index) {
    return Text(userData[index].email, style: TextStyle(fontSize: 14));
  }
}
