import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlantdetailsView extends StatefulWidget {
  final String plantName;

  PlantdetailsView({required this.plantName});

  @override
  State<PlantdetailsView> createState() => _PlantdetailsViewState();
}

class _PlantdetailsViewState extends State<PlantdetailsView> {
  dynamic plantInfo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPlantDetails(context);
  }

  Future<void> fetchPlantDetails(BuildContext context) async {
    final url = Uri.parse('http://192.168.29.168:8000/plant');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': widget.plantName}),
      );

      if (response.statusCode == 200) {
        plantInfo = json.decode(response.body);
        print(plantInfo);
        isLoading = false;
        setState(() {});
      } else {
        // If that response was not OK, throw an error.
      }
    } catch (e) {
      // For any errors during the request, return the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    // Display your plant details here
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Align text to the start
                    children: plantInfo != null
                        ? plantInfo.entries.map<Widget>((entry) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Center the content
                              children: [
                                Text(entry.key,
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .bold)), // Key with bold style
                                SizedBox(
                                    height: 8), // Space between key and value
                                Text(entry.value.toString()), // Value as string
                                SizedBox(
                                    height:
                                        16), // Space between key-value pairs
                              ],
                            );
                          }).toList()
                        : [
                            Text("No data available")
                          ], // Show this text if plantInfo is null
                  ),
                ),
              ),
      ),
    );
  }
}
