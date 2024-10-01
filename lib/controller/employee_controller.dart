import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';  // Import for jsonEncode

import '../constants.dart';

class EmployeeController extends GetxController {
  // RxString for the form fields
  var username = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var userType = ''.obs;
  var locality = ''.obs;
  var phoneNumber = ''.obs;

  // Password visibility toggle
  var isPasswordVisible = false.obs;

  // Field-specific errors
  var fieldErrors = <String, String?>{}.obs;

  // Dropdown options for userType and locality (actual backend values and display values)
  final Map<String, String> userTypes = {
    'Manager': 'Manager',
    'LocalityManager': 'Locality Manager',
    'Caller': 'Caller',
    'Visitor': 'Visitor',
    'VisitorCaller': 'Visitor and Caller'
  };

  final Map<String, String> localities = {
    'east': 'East',
    'west': 'West',
    'north': 'North',
    'south': 'South',
    'central': 'Central'
  };

  // Rx variables to store loading and error states
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Function to create an employee
  Future<void> createEmployee() async {
    // if (email.value.isEmpty || password.value.isEmpty) {
    //   errorMessage.value = "Email and password are required";
    //   return;
    // }
    if (username.value.isEmpty) {
      fieldErrors['username'] = "Username is required";
      return;
    }
    if (email.value.isEmpty) {
      fieldErrors['email'] = "Email is required";
      return;
    }
    // len of password should be greater than 8
    if (password.value.length < 8) {
      print(password.value.length);
      fieldErrors['password'] = "Password should be at least 8 characters long";
      return;
    }
    if (userType.value.isEmpty) {
      // errorMessage.value = "User type is required";
      print("User type is required");
      fieldErrors['user_type'] = "User type is required";
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    fieldErrors.clear();  // Clear previous field errors

    // Create the employee object to send as JSON
    var body = jsonEncode({
      "username": username.value,
      "email": email.value,
      "password": password.value,
      "user_type": userType.value,
      "locality": locality.value,
      "phone_number": phoneNumber.value,
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      var response = await http.post(
        Uri.parse('$HOSTNAME/organization/employees/'),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 201) {
        Get.snackbar("Success", "Employee created successfully!");
      } else if (response.statusCode == 400) {
        var responseBody = jsonDecode(response.body);

        // Map errors to fields (for example: {"email": ["Enter a valid email address."]})
        responseBody.forEach((key, value) {
          if (key == "non_field_errors") {
            fieldErrors['email'] = value[0];
          }
          if (value is List && value.isNotEmpty) {
            fieldErrors[key] = value[0];
            print("$key: ${value[0]}");
          }
        });

        errorMessage.value = "Validation errors occurred.";
      } else {
        errorMessage.value = "Error: ${response.body}";
      }
    } catch (e) {
      errorMessage.value = "Exception: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
