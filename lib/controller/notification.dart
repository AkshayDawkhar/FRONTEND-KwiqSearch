import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:takeahome/constants.dart';

import '../model/notification.dart';

class FollowupController extends GetxController {
  List<FollowupNotification> followupNotifications = [];
  bool isLoad = false;
  DateTime targetDate = DateTime.now();
  bool done = true;

  Future<void> fetchFollowupNotifications() async {
    try {
      final response = await http.get(
          Uri.parse('$HOSTNAME/client/followups/?target_date=${targetDate.year}-${targetDate.month}-${targetDate.day}${done ? '&done=True' : ''}'));

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        followupNotifications = responseData.map((item) {
          return FollowupNotification.fromJson(item);
        }).toList();
      } else {
        throw Exception('Failed to load followup notifications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    } finally {
      isLoad = true;
      update();
    }
  }

  void switchDone() {
    done = !done;
    fetchFollowupNotifications();
  }

  @override
  void onInit() {
    super.onInit();
    fetchFollowupNotifications();
  }
}
