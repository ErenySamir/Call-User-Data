import '../Model/PersonData.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PersonRepo {
  final String apiUrl = "https://reqres.in/api/users"; // Example API URL

  Future<UsersData?> fetchUserData(int id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$id'));

      if (response.statusCode == 200) {
        // If server returns a successful response
        return UsersData.fromJson(json.decode(response.body));
      } else {
        // If the server did not return a 200 OK response
        print("Failed to load data");
        return null;
      }
    } catch (error) {
      print("Error fetching data: $error");
      return null;
    }
  }
}