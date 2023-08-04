import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:takeahome/constants.dart';

import '../model/add_project.dart';
import '../model/intrested.dart';

class InterestedController extends GetxController {
  // List<FollowupNotification> followupNotifications = [];
  InterestedController({required this.projectId});

  int projectId;
  bool isLoad = false;
  DateTime targetDate = DateTime.now();
  List<Unit> units = [];
  List<InterestedModel> interested = [];
  int selectedUnitIndex = 0;

  Future<void> fetchProjectUnits() async {
    try {
      final response = await http.get(Uri.parse('$HOSTNAME/home/unit/$projectId/'));
      if (response.statusCode == 200) {
        units = unitFromJson(response.body);
        print(units);
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

  void switchUnit(int index, id) {
    selectedUnitIndex = index;
    // Get.defaultDialog(title: 'name');
    fetchInterested(id);
    update();
  }

  void fetchInterested(int unitId) async {
    try {
      final response = await http.get(Uri.parse('$HOSTNAME/home/unit/interested/$unitId/'));
      if (response.statusCode == 200) {
        // units = unitFromJson(response.body);
        // interestedFromJson()
        interested = interestedModelFromJson(response.body);
        print(response.body);
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

  @override
  void onInit() {
    super.onInit();
    fetchProjectUnits();
  }
}
