import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/model/unit.dart';

// import 'unit.dart';

// Import the Unit model class

class UnitController extends GetxController {
  // RxList to store the list of units
  RxList<Unit> units = RxList<Unit>();
  List<Unit> filteredList = [];

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
    try {
      // Replace the URL below with the actual API endpoint that provides the JSON data
      final response = await http.get(Uri.parse('$HOSTNAME/home/projects/'));
      if (response.statusCode == 200) {
        // If the request is successful, parse the JSON data and update the units list
        final List<dynamic> jsonData = json.decode(response.body);
        units.value = jsonData.map((unitData) => Unit.fromMap(unitData)).toList();
      } else {
        // If the request fails, print the error message
        print('Failed to fetch units: ${response.statusCode}');
      }
    } catch (e) {
      // If an exception occurs, print the error message
      print('Error fetching units: $e');
    }
    update();
  }

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
    if (startingBudget != null) {
      filteredList = filteredList.where((p0) => p0.price >= startingBudget).toList();
      print('starting ${filteredList.length}');
      filteredList.forEach((element) {
        print(element.toMap());
      });
    }
    if (endingBudget != null) {
      filteredList = filteredList.where((p0) => p0.price <= endingBudget).toList();
      print('Ending ${filteredList.length}');
      filteredList.forEach((element) {
        print(element.toMap());
      });
    }
    if (startingCA != null) {
      filteredList = filteredList.where((p0) => p0.carpetArea >= startingCA).toList();
      print('starting ${filteredList.length}');
      filteredList.forEach((element) {
        print(element.toMap());
      });
    }
    if (endingCA != null) {
      filteredList = filteredList.where((p0) => p0.carpetArea <= endingCA).toList();
      print('Ending ${filteredList.length}');
      filteredList.forEach((element) {
        print(element.toMap());
      });
    }
    if (amenities != null) {
      filteredList = filteredList.where((p0) => getAmenitiesNumebr(p0.amenities) >= amenities).toList();
      print('Amenities ${filteredList.length}');
      filteredList.forEach((element) {
        print(element.toMap());
      });
    }
    if (selectedUnits.isNotEmpty) {
      filteredList = filteredList.where((p0) => selectedUnits.contains(p0.unit)).toList();
      print('Units ${filteredList.length}');
      filteredList.forEach((element) {
        print(element.toMap());
      });
    }
    if (selectedAreas.isNotEmpty) {
      filteredList = filteredList.where((p0) => selectedAreas.contains(p0.area)).toList();
      print('Area ${filteredList.length}');
      filteredList.forEach((element) {
        print(element.toMap());
      });
    }
    if (duration > 0) {
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
    dateTime = DateTime.now().add(Duration(days: selected * 31));
    update();
  }

  void updateSelectedAmenities(int selected) {
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
