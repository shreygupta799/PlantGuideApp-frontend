import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/utils/routes/routesNames.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends ChangeNotifier {
  bool _loading = false;
  final _storage = const FlutterSecureStorage();
  bool get Loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<String?> loadToken() async {
    String? _token = await _storage.read(key: 'token');
    return _token;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
    notifyListeners();
  }

  Future<void> loginUser(Map user, BuildContext context) async {
    setloading(true);
    final username = user['username'];
    final password = user['password'];

    final url = Uri.parse('http://192.168.29.168:8000/login');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = 'username=$username&password=$password';
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['access_token'];
      await _storage.write(key: 'token', value: token);
      setloading(false);
      print('User Login successfully');
      Fluttertoast.showToast(
          msg: 'User Login successfully', toastLength: Toast.LENGTH_SHORT);
      Navigator.pushNamed(context, RoutesName.home);
    } else {
      setloading(false);
      print('Failed to Login user');
      Fluttertoast.showToast(
          msg: response.body, toastLength: Toast.LENGTH_LONG);
      print(response.body); // Print error message from server
    }
  }
}
