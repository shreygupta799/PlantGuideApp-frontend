import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/model/plant_model.dart';
import 'package:http/http.dart' as http;

class PlantViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  
// ! figure out correct return type
  Future<dynamic> getPlantsDetails(String name) async {
    setLoading(true);
    final url = Uri.parse('');
    final response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(name),
    );

    if (response.statusCode == 200) {
      setLoading(false);
      return PlantModel.fromJson(jsonDecode(response.body));
    } else {
      setLoading(false);
      Fluttertoast.showToast(
          msg: 'Failed to get details', toastLength: Toast.LENGTH_SHORT);
      print('Failed to get details');
      print(response.body); // Print error message from server
    }
  }
}
