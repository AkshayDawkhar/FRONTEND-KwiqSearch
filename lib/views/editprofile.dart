import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../controller/ProfileController.dart';

class EditProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _ProfileForm(),
      ),
    );
  }
}

class _ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<_ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Obx(() => TextFormField(
            initialValue: profileController.name.value,
            decoration: InputDecoration(labelText: 'Name', hintText: 'Enter your name'),
            onChanged: (value) => profileController.name.value = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          )),
          Obx(() => TextFormField(
            initialValue: profileController.email.value,
            decoration: InputDecoration(labelText: 'Email', hintText: 'Enter your email'),
            enabled: false, // Make email non-editable
          )),
          Obx(() => TextFormField(
            initialValue: profileController.organization.value,
            decoration: InputDecoration(labelText: 'Organization', hintText: 'Enter your organization'),
            enabled: false, // Make organization non-editable
          )),
          Obx(() => TextFormField(
            initialValue: profileController.locality.value,
            decoration: InputDecoration(labelText: 'Locality', hintText: 'Enter your locality'),
            onChanged: (value) => profileController.locality.value = value,
          )),
          Obx(() => TextFormField(
            initialValue: profileController.phoneNumber.value, // Add this line
            decoration: InputDecoration(labelText: 'Phone Number', hintText: 'Enter your phone number'),
            onChanged: (value) => profileController.phoneNumber.value = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          )),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _updateProfile,
            child: _isLoading ? CircularProgressIndicator() : Text('Save Changes'),
            style: ElevatedButton.styleFrom(),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final profileController = Get.find<ProfileController>();
      try {
        final authToken = await _fetchAuthToken();

        if (authToken != null) {
          final response = await http.put(
            Uri.parse('$HOSTNAME/organization/profile/'),
            headers: {
              'Authorization': 'Token $authToken',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'name': profileController.name.value,
              'phone_number': profileController.phoneNumber.value, // Include phone number
              'locality': profileController.locality.value,
            }),
          );

          if (response.statusCode == 200) {
            await profileController.fetchProfile();
            Get.snackbar('Success', 'Profile updated successfully');
            // Get.back();
            Navigator.of(context).pop();
          } else {
            // Handle errors with more specific messages if possible
            Get.snackbar('Error', 'Failed to update profile: ${response.statusCode}');
          }
        } else {
          Get.snackbar('Error', 'User not authenticated');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred while updating the profile: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<String?> _fetchAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
