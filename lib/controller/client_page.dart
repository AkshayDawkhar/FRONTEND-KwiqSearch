import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:takeahome/model/client_page.dart';

import '../constants.dart';

// class ClientController extends GetxController {
//   RxList<Client> clients = RxList<Client>([]);
//   bool isLoad = false;
//   @override
//   void onInit() {
//     super.onInit();
//     fetchClients();
//     print('$clients');
//     clients.forEach((element) {
//       print('$element');
//     });
//   }
//
//   Future<void> fetchClients() async {
//     try {
//       final response =
//           await http.get(Uri.parse('http://192.168.1.43:8000/client/clients/'));
//       if (response.statusCode == 200) {
//         List<dynamic> jsonData = json.decode(response.body);
//         clients.value =
//             jsonData.map((clientData) => Client.fromMap(clientData)).toList();
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//     print('$clients');
//     update();
//   }
// }
//
// class FollowUpController extends GetxController {
//   RxList<FollowUP> followUP = RxList<FollowUP>([]);
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchClients();
//   }
//
//   Future<void> fetchClients() async {
//     try {
//       final response = await http.get(
//           Uri.parse('http://192.168.1.43:8000/client/followups/?client_id=1'));
//       if (response.statusCode == 200) {
//         List<dynamic> jsonData = json.decode(response.body);
//         followUP.value =
//             jsonData.map((clientData) => FollowUP.fromMap(clientData)).toList();
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//     print('$followUP');
//     update();
//   }
// }
//
class CreateFollowUPController extends GetxController {
  final fromKey = GlobalKey<FormState>();
  TextEditingController message = TextEditingController();
  TextEditingController action = TextEditingController();

  // TextEditingController dateController = TextEditingController();
  // TextEditingController timeController = TextEditingController();

  // TextEditingController action = TextEditingController();
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
          cancel: TextButton(onPressed: () {Get.toNamed('client-page');}, child: Text('OK')));
    }else{
      Get.defaultDialog(
          title: 'Error',
          backgroundColor: Colors.redAccent,
          content: Text('Something Went Wrong'),
          cancel: TextButton(onPressed: () {Get.back();}, child: Text('OK')));
    }
    print(response.statusCode);
    // Get.defaultDialog(title: responce.body);
  }
}

class ClientController extends GetxController {
  late Client client;
  bool isLoad = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchClient();
  }

  void fetchClient() async {
    final url = Uri.parse('$HOSTNAME/client/client/1/');
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
}
