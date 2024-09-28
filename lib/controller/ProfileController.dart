import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takeahome/constants.dart';


class ProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var organization = ''.obs;
  var phoneNumber = ''.obs;
  var locality = ''.obs;
  var userType = ''.obs;
  var assignedTo = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile(); // Fetch profile when controller is initialized
    fetchOrgProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token != null) {
        final response = await http.get(
          Uri.parse('$HOSTNAME/organization/profile/'), // Adjust the URL if necessary
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          name.value = data['name'] ?? '';
          email.value = data['email'] ?? '';
          organization.value = data['organization'] ?? '';
          locality.value = data['locality'] ?? '';
          userType.value = data['user_type'] ?? '';
          assignedTo.value = data['assigned_to'] != null ? data['assigned_to'].toString() : ''; // Handle if there's no manager
          phoneNumber.value = data['phone_number'] ?? '';
        }
        else if (response.statusCode == 401) {
          Logout(); // Logout if token is invalid
        }
        else {
          Get.snackbar('Error', 'Failed to load profile data');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching profile data');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> fetchOrgProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token != null) {
        final response = await http.get(
          Uri.parse('$HOSTNAME/organization/employees/'), // Adjust the URL if necessary
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'application/json',
          },
        );
        print(response.body);
        // if (response.statusCode == 200) {
        //   var data = json.decode(response.body);
        //   name.value = data['name'] ?? '';
        //   email.value = data['email'] ?? '';
        //   organization.value = data['organization'] ?? '';
        //   locality.value = data['locality'] ?? '';
        //   userType.value = data['user_type'] ?? '';
        //   assignedTo.value = data['assigned_to'] != null ? data['assigned_to'].toString() : ''; // Handle if there's no manager
        //   phoneNumber.value = data['phone_number'] ?? '';
        // }
        // else if (response.statusCode == 401) {
        //   Logout(); // Logout if token is invalid
        // }
        // else {
        //   Get.snackbar('Error', 'Failed to load profile data');
        // }
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching profile data');
    } finally {
      isLoading.value = false;
    }
  }
}
