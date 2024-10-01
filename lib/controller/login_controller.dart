import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takeahome/constants.dart';

class LoginController extends GetxController {
  var organizationId = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  Future<void> login() async {
    isLoading(true);
    final _formKey = GlobalKey<FormState>(); // Initialize form key
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
        Uri.parse('$HOSTNAME/organization/login/'), // Replace with your API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'organization_id': organizationId.value,
          'email': email.value,
          'password': password.value,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final token = data['token'];
        final userType = data['user_type'];
        print('Token: $token');
        print('User Type: $userType');
        print('Organization ID: ${organizationId.value}');
        print('Email: ${email.value}');
        print('Password: ${password.value}');
        // Store token and user type in SharedPreferences
        await prefs.setString('auth_token', token);
        await prefs.setString('user_type', userType);

        // Navigate to the appropriate screen based on user type
        // if (userType == 'LocalityManager'|| userType == 'CEO' || userType == 'Manager'|| userType == 'Caller'|| userType == 'Visitor'|| userType == 'VisitorCaller'|| userType == 'caller' || userType == 'visitor') {
        // if usertype in ['LocalityManager', 'CEO', 'Manager', 'Caller', 'Visitor', 'VisitorCaller', 'caller', 'visitor']:
        if ([ 'LocalityManager', 'CEO', 'Manager', 'Caller', 'Visitor', 'VisitorCaller', 'caller', 'visitor' ].contains(userType)) {
        Get.offNamed('/home'); // Navigate based on user type
        } else {
          Get.snackbar('Info', 'Unknown user type');
        }
      } else {
        Get.snackbar('Error', 'Invalid credentials or organization ID');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred$e');
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
