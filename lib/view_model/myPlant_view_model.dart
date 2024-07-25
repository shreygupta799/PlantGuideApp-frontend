import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/view_model/splash_view_model.dart';
import 'package:http/http.dart' as http;

class MyplantViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get Loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<dynamic> getPlantInfo(String plantName) async {
    final url = Uri.parse('http://192.168.29.168:8000/plant');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': plantName}),
      );

      if (response.statusCode == 200) {
        setloading(false);
        return json.decode(response.body);
      } else {
        // If that response was not OK, throw an error.
        setloading(false);
        return 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      setloading(false);
      // For any errors during the request, return the error
      return 'Error: $e';
    }
  }
}
