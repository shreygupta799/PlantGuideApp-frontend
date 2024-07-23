import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/utils/routes/routesNames.dart';
import 'package:http/http.dart' as http;

class AuthViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get Loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> registerUser(Map user, BuildContext context) async {
    setloading(true);
    final url = Uri.parse('http://192.168.29.168:8000/register');
    final response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Registered Successfully', toastLength: Toast.LENGTH_SHORT);
      Navigator.pushNamed(context, RoutesName.login);

      setloading(false);
      print('User registered successfully');
    } else if (response.statusCode == 409) {
      setloading(false);
      Fluttertoast.showToast(
          msg: 'User already exists', toastLength: Toast.LENGTH_SHORT);
      print('User already exists');
    } else {
      setloading(false);
      Fluttertoast.showToast(
          msg: 'Failed to register user', toastLength: Toast.LENGTH_SHORT);
      print('Failed to register user');
      print(response.body); // Print error message from server
    }
  }
}
