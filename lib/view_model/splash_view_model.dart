import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/model/currentUser_model.dart';
import 'package:frontend/view_model/auth_view_Model.dart';
import 'package:frontend/view_model/login_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SplashViewModel extends ChangeNotifier {
  bool _isSplash = true;
  CurrentUserModel? _currentUser;
  bool get isSplash => _isSplash;
  CurrentUserModel? get currentUser => _currentUser;

  void changeSplash(bool value) {
    _isSplash = value;
    notifyListeners();
  }

  void setCurrentUser(CurrentUserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getCurrentUser(final token) async {
    final url = Uri.parse('http://192.168.29.168:8000/users/me');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final user = CurrentUserModel.fromJson(json.decode(response.body));
      setCurrentUser(user);
      return json.decode(response.body);
    } else {
      print(response.body);
      return null;
    }
  }
}
