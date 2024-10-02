import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/model/unit.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'unit.dart';

// Import the Unit model class

class UnitController extends GetxController {
  // RxList to store the list of units
  RxList<UnitDetails> units = RxList<UnitDetails>();
  List<UnitDetails> filteredList = [];
  bool isLoad = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  Future<void> init() async {
    fetchUnits();
    filteredList = units;
    update();
  }

  // Function to fetch the JSON data and update the units list
  Future<void> fetchUnits() async {
    isLoad = false;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    update();
    try {
      // Replace the URL below with the actual API endpoint that provides the JSON data
      final response = await http.get(Uri.parse('$HOSTNAME/home/projects/'),
      headers: {
        'Authorization': 'Token $token',
        // 'Content-Type': 'application/json',
      },
      );

      if (response.statusCode == 200) {
        // If the request is successful, parse the JSON data and update the units list
        final List<dynamic> jsonData = json.decode(response.body);
        units.value = jsonData.map((unitData) => UnitDetails.fromMap(unitData)).toList();
      } else {
        // If the request fails, print the error message
        print('Failed to fetch units: ${response.statusCode}');
      }
    } catch (e) {
      // If an exception occurs, print the error message
      print('Error fetching units: $e');
    }
    isLoad = true;
    update();
  }

  // forLoops() async {
  //   final ReceivePort receivePort = ReceivePort();
  //   try {
  //     await Isolate.spawn((message) {
  //       for (int i = 0; i < 9999999999; i++) {}
  //       print("done")
  //     }, message)
  //   } catch (Ex) {
  //
  //   }
  // }
  Set<String> filters = {};

  void filterData(
      {var startingBudget,
      var endingBudget,
      var amenities,
      var startingCA,
      var endingCA,
      required List<double> selectedUnits,
      required List<String> selectedAreas,
      var duration}) async {
    filteredList = units;
    filters = {};
    if (selectedAreas.isNotEmpty) {
      filters.add('Areas');
      filteredList = filteredList.where((p0) => selectedAreas.contains(p0.area)).toList();
      print('Area ${filteredList.length}');
      // filteredList.forEach((element) {
      //   print(element.toMap());
      // });
    }
    if (selectedUnits.isNotEmpty) {
      filters.add('Units');
      filteredList = filteredList.where((p0) => selectedUnits.contains(p0.unit)).toList();
      print('Units ${filteredList.length}');
      // filteredList.forEach((element) {
      //   print(element.toMap());
      // });
    }
    if (startingBudget != null && startingBudget != 3500000) {
      filters.add('Budget');
      filteredList = filteredList.where((p0) => p0.price >= startingBudget).toList();
      print('starting ${filteredList.length}');
      // filteredList.forEach((element) {
      //   print(element.toMap());
      // });
    }
    if (endingBudget != null&& endingBudget != 30000000) {
      filters.add('Budget');
      filteredList = filteredList.where((p0) => p0.price <= endingBudget).toList();
      print('Ending ${filteredList.length}');
      // filteredList.forEach((element) {
      //   print(element.toMap());
      // });
    }
    if (startingCA != null && startingCA != 300) {
      filters.add('Carpet Area');

      filteredList = filteredList.where((p0) => p0.carpetArea >= startingCA).toList();
      print('starting ${filteredList.length}');
      // filteredList.forEach((element) {
      //   print(element.toMap());
      // });
    }
    if (endingCA != null && endingCA != 5000) {
      filters.add('Carpet Area');
      filteredList = filteredList.where((p0) => p0.carpetArea <= endingCA).toList();
      print('Ending ${filteredList.length}');
      // filteredList.forEach((element) {
      //   print(element.toMap());
      // });
    }
    if (amenities != null&&amenities != 0) {
      filters.add('Amenities');
      // print(amenities);
      filteredList = filteredList.where((p0) => getAmenitiesNumebr(p0.amenities) >= amenities).toList();
      print('Amenities ${filteredList.length}');
      // filteredList.forEach((element) {
        // print(element.toMap());
      // });
    }
    if (duration > 0) {
      filters.add('Duration');
      filteredList = filteredList.where((p0) => p0.possession.isBefore(DateTime.now().add(Duration(days: duration * 35)))).toList();
      print('Date Time ${filteredList.length} $duration');
      filteredList.forEach((element) {
        print(element.possession.isBefore(DateTime.now().add(Duration(days: duration * 35))));
      });
    }
    update();
  }
}

class FilterController extends GetxController {
  List<String> selectedAreas = [];
  List<double> selectedUnits = [];
  int selectedDurations = 0;
  int selectedAmenities = 0;
  DateTime dateTime = DateTime.now();
  RangeValues budgetRange = RangeValues(3500000, 30000000);
  RangeValues carpetAreaRange = RangeValues(300, 5000);
  List<MultiSelectItem<double>> bhks = [
    MultiSelectItem(0.0, 'Plot'),
    MultiSelectItem(0.1, 'Custom office'),
    MultiSelectItem(0.2, 'Custom shop'),
    MultiSelectItem(0.5, 'RK'),
    MultiSelectItem(1, '1 BHK'),
    MultiSelectItem(1.5, '1.5 BHK'),
    MultiSelectItem(2, '2 BHK'),
    MultiSelectItem(2.5, '2.5 BHK'),
    MultiSelectItem(3, '3 BHK'),
    MultiSelectItem(3.5, '3.5 BHK'),
    MultiSelectItem(4, '4 BHK'),
    MultiSelectItem(4.5, '4.5 BHK'),
    MultiSelectItem(5, '5 BHK'),
    MultiSelectItem(6, '6 BHK'),
  ];

  List<DropdownMenuItem> durations = [
    DropdownMenuItem(
      child: Text('Ready To Move'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('3 Month'),
      value: 3,
    ),
    DropdownMenuItem(
      child: Text('6 Month'),
      value: 6,
    ),
    DropdownMenuItem(
      child: Text('1 Year'),
      value: 12,
    ),
    DropdownMenuItem(
      child: Text('1.5 Year'),
      value: 18,
    ),
    DropdownMenuItem(
      child: Text('2 Year'),
      value: 24,
    ),
    DropdownMenuItem(
      child: Text('2.5 Year'),
      value: 30,
    ),
    DropdownMenuItem(
      child: Text('3 Year'),
      value: 36,
    ),
    DropdownMenuItem(
      child: Text('3+ Year'),
      value: 120,
    ),
  ];
  List<DropdownMenuItem> amenities = const [
    DropdownMenuItem(child: Text('All Amenities'), value: 2),
    DropdownMenuItem(child: Text('Basic Amenities'), value: 1),
    DropdownMenuItem(child: Text('No Amenities'), value: 0),
  ];
  var amenity = null;
  var duration = null;

  void setDefault() {
    selectedAreas = [];
    selectedUnits = [];
    selectedDurations = 0;
    selectedAmenities = 0;
    dateTime = DateTime.now();
    budgetRange = RangeValues(3500000, 30000000);
    carpetAreaRange = RangeValues(300, 5000);
    amenity = null;
    duration = null;
    update();
  }

  void updateSelectedAreas(List<String> selected) {
    selectedAreas = selected;
    update(); // Manually notify the UI to update
  }

  void updateSelectedUnits(List<double> selected) {
    selectedUnits = selected;
    update();
  }

  void updateSelectedDurations(int selected) {
    selectedDurations = selected;
    duration = selected;
    dateTime = DateTime.now().add(Duration(days: selected * 31));
    update();
  }

  void updateSelectedAmenities(int selected) {
    amenity = selected;
    selectedAmenities = selected;
    update();
  }

  void updateBudgetRange(RangeValues range) {
    budgetRange = range;
    update();
  }

  void updateCarpetAreaRange(RangeValues range) {
    carpetAreaRange = range;
    update();
  }

  Map<String, dynamic> toMap() {
    return {
      "Area": selectedAreas,
      "units": selectedUnits,
      "possession": dateTime.toIso8601String(),
      "amenities": selectedAmenities,
      "startBudget": budgetRange.start,
      "stopBudget": budgetRange.end,
      "startCarpetArea": carpetAreaRange.start,
      "stopCarpetArea": carpetAreaRange.end,
    };
  }

  List<MultiSelectItem<String>> areas = [];

  void getAreas() async {
    final url = Uri.parse('$HOSTNAME/home/areas/');
    final responce = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    List a = json.decode(responce.body);
    areas = a
        .map((e) => MultiSelectItem(
              e['formatted_version'].toString(),
              e['name'],
            ))
        .toList();
    print(areas);
    update();
    // print(a.first[]);
  }

  void search() async {
    print(selectedAreas.toString());
    print(selectedUnits.toString());
    print(selectedDurations);
    print(selectedAmenities);
    print(budgetRange);
    print(carpetAreaRange);

    dateTime.add(Duration(days: selectedDurations * 30));
    Map ad = {
      "Area": selectedAreas,
      "units": selectedUnits,
      "possession": dateTime.toIso8601String(),
      "amenities": selectedAmenities,
      "startBudget": budgetRange.start,
      "stopBudget": budgetRange.end,
      "startCarpetArea": carpetAreaRange.start,
      "stopCarpetArea": carpetAreaRange.end,
    };
    String a = json.encode(ad);
    final url = Uri.parse('$HOSTNAME/client/searchfilters/');
    final responce = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: a);
    print(responce.body);
    print(responce.statusCode);
    print(a);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAreas();
  }
}
