// import 'package:flutter/material.dart';
//
// class Room {
//   final String? area;
//   final List<String>? units;
//   final String? passation;
//   final RangeValues? carpetArea;
//   final String? amendments;
//   final String? budget;
//
//   Room({
//     this.area,
//     this.units,
//     this.passation,
//     this.carpetArea,
//     this.amendments,
//     this.budget,
//   });
// }
//
//
// class FilterOptions {
//   final String? area;
//   final List<String>? units;
//   final String? passation;
//   final RangeValues? carpetArea;
//   final String? amendments;
//   final String? budget;
//
//   FilterOptions({
//     this.area,
//     this.units,
//     this.passation,
//     this.carpetArea,
//     this.amendments,
//     this.budget,
//   });
// }
//
// List<Room> applyFilters(List<Room> rooms, FilterOptions options) {
//   return rooms
//       .where((room) => options.area == null || room.location == options.area)
//       .where((room) => options.units == null || options.units!.isEmpty || options.units!.contains(room.unit))
//       .where((room) => options.passation == null || room.passation == options.passation)
//       .where((room) =>
//   options.carpetArea == null ||
//       (room.carpetArea! >= options.carpetArea!.start && room.carpetArea <= options.carpetArea!.end))
//       .where((room) => options.amendments == null || room.amendments == options.amendments)
//       .where((room) => options.budget == null || room.budget == options.budget)
//       .toList();
// }
//
//
//   List<Room> rooms = [
//     // Room objects
//   ];
//
//   FilterOptions filterOptions = FilterOptions(
//     area: 'City X', // User-selected area
//     units: ['1 BHK', '2 BHK'], // User-selected units
//     passation: '1 Year', // User-selected passation
//     carpetArea: RangeValues(10, 20), // User-selected carpet area range
//     amendments: 'Yes', // User-selected amendments
//     budget: '61 - 71', // User-selected budget range
//   );
//
//   List<Room> filteredRooms = applyFilters(rooms, filterOptions);
//   print(filteredRooms);
//
class Room {
  String name;
  int number;
  String loc;
  double bhk;

  Room({required this.name, required this.number, required this.loc, required this.bhk});
}
