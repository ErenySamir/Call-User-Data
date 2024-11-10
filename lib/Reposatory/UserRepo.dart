import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prefectioncompany/Model/UserModel.dart';

import '../Model/PersonData.dart';

class AllUsersData {
  final String apiUrl = 'https://reqres.in/api/users?page=1';

  Future<UserModel?> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print("Response::: ${response.body}");
        // Parse the JSON response
        return UserModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Return null in case of an error
    }
  }
}


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