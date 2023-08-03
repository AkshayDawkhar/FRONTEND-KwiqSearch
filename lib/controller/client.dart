import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:takeahome/model/client.dart';

import '../constants.dart';

class CreateFollowUPController extends GetxController {
  final fromKey = GlobalKey<FormState>();
  TextEditingController message = TextEditingController();
  TextEditingController action = TextEditingController();

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  void getDate(DateTime dateTime) async {
    date = dateTime;
    // dateController.text = dateToString(dateTime);
    update();
  }

  void send(int id) async {
    final url = Uri.parse('$HOSTNAME/client/followups/');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "message": message.text,
          "actions": action.text,
          "date_sent": DateTime(date.year, date.month, date.day, time.hour, time.minute).toIso8601String(),
          "client": id
        }));
    if (response.statusCode == 201) {
      Get.defaultDialog(
          title: 'Successful',
          backgroundColor: Colors.greenAccent,
          content: Text('Followup Created Successfully'),
          cancel: TextButton(
              onPressed: () {
                // Get.toNamed('client');
                Get.back();
                Get.back();

              },
              child: Text('OK')));
    } else {
      Get.defaultDialog(
          title: 'Error',
          backgroundColor: Colors.redAccent,
          content: Text('Something Went Wrong'),
          cancel: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK')));
    }
    print(response.statusCode);
    // Get.defaultDialog(title: responce.body);
  }

  Future<Followup> getFollowUp(int id) async {
    final String apiUrl = "$HOSTNAME/client/followups/$id";
    final response = await http.get(
      Uri.parse(apiUrl),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    return Followup.fromJson(data);
  }
}

class ClientController extends GetxController {
  late Client client;
  bool isLoad = false;
  int id;

  ClientController({required this.id});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchClient();
  }

  void fetchClient() async {
    final url = Uri.parse('$HOSTNAME/client/client/$id/');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // print(response.body);
    Map<String, dynamic> a = json.decode(response.body);
    // print(a);
    client = Client.fromJson(a);
    print(client.toJson());
    isLoad = true;
    update();
    // return 1;
  }

  void addFeedback({required int followUp, required String message, required String response}) async {
    final Map<String, dynamic> data = {
      "follow_up": followUp,
      "message": message,
      "response": response,
    };
    final apiResponse = await http.post(
      Uri.parse('$HOSTNAME/client/feedbacks/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (apiResponse.statusCode == 200) {
      print("POST request successful!");
      print(apiResponse.body);
    } else {
      print("Error during POST request.");
      print("Status code: ${apiResponse.statusCode}");
      print("Response body: ${apiResponse.body}");
    }
  }
  void deleteClient() async {
    final String url = '$HOSTNAME/client/client/$id/';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        print('DELETE request successful!');
        Get.offAllNamed('/home');
        // Get.back();
      } else {
        print('DELETE request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error making DELETE request: $e');
    }
  }
}

class ClientsController extends GetxController {
  List<Clients> clients = [];
  bool isLoad = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchClient();
  }

  void fetchClient() async {
    final url = Uri.parse('$HOSTNAME/client/client/');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // Map<String, dynamic> a = json.decode(response.body);
    clients = clientsFromJson(response.body);
    // print(clients);
    isLoad = true;
    update();
  }
}
