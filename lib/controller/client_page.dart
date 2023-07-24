import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:takeahome/model/client_page.dart';

class ClientController extends GetxController {
  RxList<Client> clients = RxList<Client>([]);

  @override
  void onInit() {
    super.onInit();
    fetchClients();
    print('$clients');
    clients.forEach((element) {
      print('$element');
    });
  }

  Future<void> fetchClients() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.43:8000/client/clients/'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        clients.value =
            jsonData.map((clientData) => Client.fromMap(clientData)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
    print('$clients');
    update();
  }
}

class FollowUpController extends GetxController {
  RxList<FollowUP> followUP = RxList<FollowUP>([]);

  @override
  void onInit() {
    super.onInit();
    fetchClients();
  }

  Future<void> fetchClients() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.1.43:8000/client/followups/?client_id=1'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        followUP.value =
            jsonData.map((clientData) => FollowUP.fromMap(clientData)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
    print('$followUP');
    update();
  }
}

class CreateFollowUPController extends GetxController {
  final fromKey = GlobalKey<FormState>();
  TextEditingController message = TextEditingController();
  TextEditingController action = TextEditingController();

  // TextEditingController action = TextEditingController();
  late DateTime dateTime;

  void send(DateTime dateTime) {
    CreateFollowUP createFollowUP = CreateFollowUP(
        message: message.text,
        actions: action.text,
        dateSent: dateTime,
        client: 1);
    print('${createFollowUP.toMap()}');
  }
}
