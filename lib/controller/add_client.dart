import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class NewClientController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();

  bool isValidEmail(String email) {
    // Add email validation logic here (e.g., using regex)
    return true;
  }

  void getOutput(Map<String, dynamic> searchFilter,int duration) async {
    // DateTime possession = searchFilter['possession'];
    // possession = possession.add(Duration(days: duration*31));
    // print('-------->>>> ${possession.year}');
    final Map<String, dynamic> data = {
      "fname": firstNameController.text,
      "lname": lastNameController.text,
      "phoneNO": phoneController.text,
      "massageNO": messageController.text,
      "email": emailController.text,
      "search_filter": {
        "Area": searchFilter['Area'],
        "units": searchFilter['units'],
        "possession": searchFilter['possession'],
        "amenities": searchFilter['amenities'],
        "startBudget": searchFilter['startBudget'],
        "stopBudget": searchFilter['stopBudget'],
        "startCarpetArea": searchFilter['startCarpetArea'],
        "stopCarpetArea": searchFilter['stopCarpetArea'],
        "requirements": requirementsController.text
      }
    };
    print(data);
    final url = Uri.parse('$HOSTNAME/client/client/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(data));
    print(response.statusCode);
    // postNewArea({"name": name, "formatted_version": name});
    if (response.statusCode == 201) {
      Get.back();
      Get.defaultDialog(title: 'Successful', content: const Text('Created successfully'), backgroundColor: Colors.greenAccent,textCancel: 'OK');
    } else {
      // Get.defaultDialog(title: 'Error', content: const Text('Something Went wrong'), backgroundColor: Colors.redAccent);
      getErrorDialog(response.body);
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // addUnit();
    // getAreas();
  }
}
