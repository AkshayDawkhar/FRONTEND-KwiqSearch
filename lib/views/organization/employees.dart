import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart'; // Assuming HOSTNAME is stored in this file.

class EmployeeListPage extends StatefulWidget {
  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  List<dynamic> employees = [];
  String? nextUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchEmployees(); // Fetch the first set of employees on page load
  }

  // Function to fetch employees from the API
  Future<void> fetchEmployees({String? url}) async {
    setState(() {
      isLoading = true;
    });

    final apiUrl = url ?? '$HOSTNAME/organization/organization/employees/?limit=7';

    try {
      // Retrieve the auth token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          employees.addAll(data['results']);
          nextUrl = data['next'];
        });
      } else {
        Get.snackbar("Error", "Failed to load employees: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to handle scrolling and fetching more data
  void _onScrollEnd() {
    if (!isLoading && nextUrl != null) {
      fetchEmployees(url: nextUrl); // Fetch next page when the user reaches the bottom
    }
  }

  // Navigate to Add Employee Page (Implement the AddEmployeePage)
  void _navigateToAddEmployee() {
    // Get.to(() => AddEmployeePage()); // Assuming AddEmployeePage is the screen to add employees
    Get.toNamed('/create-employee'); // Navigate to the Add Employee screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _onScrollEnd(); // Trigger when the user scrolls to the bottom
          }
          return false;
        },
        child: ListView.builder(
          itemCount: employees.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == employees.length) {
              // Show loading indicator at the bottom of the list when loading more data
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final employee = employees[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee['username'] ?? 'No Username',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.grey[600]),
                          SizedBox(width: 8.0),
                          Expanded( // This will allow the text to adjust
                            child: Text(
                              'Email: ${employee['email'] ?? 'N/A'}',
                              style: TextStyle(color: Colors.grey[700]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.grey[600]),
                          SizedBox(width: 8.0),
                          Text(
                            'User Type: ${employee['user_type'] ?? 'N/A'}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey[600]),
                          SizedBox(width: 8.0),
                          Text(
                            'Locality: ${employee['locality'] ?? 'N/A'}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.grey[600]),
                          SizedBox(width: 8.0),
                          Text(
                            'Phone: ${employee['phone_number'] ?? 'N/A'}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddEmployee, // Navigate to the Add Employee screen
        // child: Icon(Icons.add),
        icon: Icon(Icons.add),
        label: Text('Add Employee'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

// Placeholder for AddEmployeePage (This should be implemented elsewhere)
class AddEmployeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Employee"),
      ),
      body: Center(
        child: Text("Employee Form Goes Here"),
      ),
    );
  }
}
