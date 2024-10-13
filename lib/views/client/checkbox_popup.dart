import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:takeahome/constants.dart';

import '../../controller/client.dart';

// Reusable function to show the Checkbox Bottom Sheet
Future<void> showCheckboxBottomSheet(BuildContext context) async {
  var clientController = Get.put(ClientController(id: int.tryParse(Get.parameters['client_id'] ?? '') ?? 0));
  List<dynamic> apiData = [];
  Map<String, bool> selectedCheckboxes = {};

  // Function to fetch data from API
  Future<void> fetchData() async {
    final token = await getToken();

    final response = await http.get(
        Uri.parse('$HOSTNAME/client/clients/employee/?client_id=30'),
        headers: {
          'Authorization': 'Token $token', // Pass the token in headers
        }
    ); // Replace with your API URL
    print(response.body);
    print(token);
    if (response.statusCode == 200) {
      apiData = json.decode(response.body);
      // Initialize the checkbox states based on `assigned`
      for (var item in apiData) {
        selectedCheckboxes[item['id']] = item['assigned'];
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Fetch data before showing bottom sheet
  await fetchData();

  // Show the bottom sheet
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allow the bottom sheet to be scrollable
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75, // Set height to 75% of screen height
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select Users', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            // Handle Save action here
                            // print(selectedCheckboxes);
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel', style: TextStyle(color: Colors.red)),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle Save action here
                            print(selectedCheckboxes);
                            List<String> selectedEmployeeIds = selectedCheckboxes.entries
                                .where((entry) => entry.value == true)
                                .map((entry) => entry.key)
                                .toList();

                            assignEmployeesToClient(context, '30', selectedEmployeeIds);
                            clientController.onInit();

                            Navigator.of(context).pop();
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                    ],
                ),
                // SizedBox(height: 16),
                Divider(),
                // Expanded ListView to hold the checkboxes
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: apiData.length,
                    itemBuilder: (context, index) {
                      final item = apiData[index];
                      return Row(
                        children: [
                          // Checkbox on the left
                          Checkbox(
                            value: selectedCheckboxes[item['id']],
                            onChanged: item['editable'] ? (bool? value) {
                              setState(() {
                                selectedCheckboxes[item['id']] = value!;
                              });
                            } : null, // Disable if editable is false
                          ),
                          // Display user details
                          Expanded(
                            child: ListTile(
                              title: Text(item['username']),
                              subtitle: Text('${item['email']} | ${item['user_type']}'), // Show user_type
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // SizedBox(height: 16),
                // Save button
                // TextButton(
                //   onPressed: () {
                //     // Handle Save action here
                //     print(selectedCheckboxes);
                //     Navigator.of(context).pop();
                //   },
                //   child: Text('Save'),
                // ),
                // SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    },
  );
}


// Function to hit the API and assign employees to the client
Future<void> assignEmployeesToClient(BuildContext context, String clientId, List<String> employeeIds) async {
  final token = await getToken(); // Fetch the token

  final url = Uri.parse('$HOSTNAME/client/clients/employee/');  // Replace with your API endpoint
  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Token $token', // Pass the token in headers
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'employee_ids': employeeIds, // Employee IDs selected from checkboxes
      'client_id': clientId,       // Client ID
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data['message']);
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Employee assigned to client successfully'),
    ));
  } else {
    final data = json.decode(response.body);
    print(data['error']);
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to assign employees: ${data['error']}'),
    ));
  }
}
