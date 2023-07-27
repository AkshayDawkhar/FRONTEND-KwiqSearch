import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:takeahome/constants.dart';
import 'package:takeahome/model/unit.dart';

import '../model/room.dart';

// import 'unit.dart';
List<Room> rooms = [
  Room(name: 'name', number: 12, loc: 'pune', bhk: 0.5),
  Room(name: 'name1', number: 13, loc: 'pune1', bhk: 2),
  Room(name: 'name2', number: 14, loc: 'pune', bhk: 2),
  Room(name: 'name3', number: 15, loc: 'pune1', bhk: 1),
  Room(name: 'name4', number: 16, loc: 'pune', bhk: 3),
  Room(name: 'name5', number: 17, loc: 'pune', bhk: 2),
  Room(name: 'name6', number: 18, loc: 'pune1', bhk: 1),
  Room(name: 'name7', number: 19, loc: 'pune', bhk: 1),
  Room(name: 'name8', number: 90, loc: 'pune', bhk: 1),
  Room(name: 'name9', number: 19, loc: 'pune1', bhk: 1.5),
];

List<Room> filterRooms({String? name, int? number, String? loc, double? bhk}) {
  return rooms
      .where((room) => room.number < number!)
      .where((room) => loc == null || room.loc == loc)
      .where((room) => bhk == null || room.bhk == bhk)
      .toList();
  // return [];
}
// Import the Unit model class

class UnitController extends GetxController {
  // RxList to store the list of units
  RxList<Unit> units = RxList<Unit>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUnits();
    // wing = wings.first;
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

  void filterData(Map filter) async {
    List<Unit> filteredUnits = units.where((unit) {
      bool areaMatch = filter["area"].isEmpty || filter["area"].contains(unit.area);
      bool unitMatch = filter["unit"].isEmpty || filter["unit"].contains(unit.unit);
      bool possessionMatch = filter["possession"].isEmpty; // Add the possession matching logic if available
      bool amenitiesMatch = filter["amenities"].isEmpty || filter["amenities"].contains(unit.amenities);
      bool budgetMatch = unit.price >= filter["startingBudget"] && unit.price <= filter["endingBudget"];
      bool carpetAreaMatch = unit.carpetArea >= filter["startingCarpetArea"] && unit.carpetArea <= filter["endingCarpetArea"];

      return areaMatch && unitMatch && possessionMatch && amenitiesMatch && budgetMatch && carpetAreaMatch;
    }).toList();
    print(filteredUnits);
  }
}

class FilterController extends GetxController {
  List<String> selectedAreas = [];
  List<double> selectedUnits = [];
  int selectedDurations = 0;
  List<String> selectedAmenities = [];
  RangeValues budgetRange = RangeValues(3500000, 30000000);
  RangeValues carpetAreaRange = RangeValues(300, 5000);
  List<DropdownMenuItem> durations = [
    DropdownMenuItem(
      child: Text('Ready To Move'),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text('6 Month'),
      value: 0.6,
    ),
    DropdownMenuItem(
      child: Text('3 Month'),
      value: 0.3,
    ),
    DropdownMenuItem(
      child: Text('1 Year'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('1.5 Year'),
      value: 1.5,
    ),
    DropdownMenuItem(
      child: Text('2 Year'),
      value: 2,
    ),
    DropdownMenuItem(
      child: Text('2.5 Year'),
      value: 2.5,
    ),
    DropdownMenuItem(
      child: Text('3 Year'),
      value: 3,
    ),
    DropdownMenuItem(
      child: Text('3+ Year'),
      value: 30,
    ),
  ];
  List<DropdownMenuItem> possessions = const [
    DropdownMenuItem(child: Text('All Amenities'), value: 'All Amenities'),
    DropdownMenuItem(child: Text('No Amenities'), value: 'No Amenities'),
    DropdownMenuItem(child: Text('Basic Amenities'), value: 'Basic Amenities'),
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
    update();
  }

  void updateSelectedAmenities(List<String> selected) {
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

  void search() {
    print(selectedAreas.toString());
    print(selectedUnits.toString());
    print(selectedDurations);
    print(selectedAmenities);
    print(budgetRange);
    print(carpetAreaRange);
    Map ad = {
      "area": selectedAreas,
      "unit": selectedUnits,
      "possession": selectedDurations,
      "amenities": amenities,
      "startingBudget": budgetRange.start,
      "endingBudget": budgetRange.end,
      "startingCarpetArea": carpetAreaRange.start,
      "endingCarpetArea": carpetAreaRange.end,
    };
    String a = json.encode(ad);
    print(a);
  }
}
