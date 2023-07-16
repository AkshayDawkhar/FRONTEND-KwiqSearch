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

  Room(
      {required this.name,
      required this.number,
      required this.loc,
      required this.bhk});
}

class Flat {
  String area;
  String name;
  double bhk;
  DateTime possession;
  int price;
  int carpetArea;

  Flat({
    required this.name,
    required this.area,
    required this.bhk,
    required this.possession,
    required this.price,
    required this.carpetArea,
  });
}

List<Flat> dummyFlats = [
  Flat(
      area: 'Mamurdi',
      bhk: 1,
      possession: DateTime(2024, 12),
      price: 3200000,
      carpetArea: 402, name: 'my flat'),
  Flat(
      area: 'Mamurdi',
      bhk: 1,
      possession: DateTime(2024, 6),
      price: 4000000,
      carpetArea: 420, name: 'my flat2'),
  Flat(
      area: 'Mamurdi',
      bhk: 2,
      possession: DateTime(2024, 3),
      price: 5000000,
      carpetArea: 700, name: 'my flat3'),
  Flat(
      area: 'Wakad',
      bhk: 2,
      possession: DateTime(2024, 3),
      price: 5000000,
      carpetArea: 700, name: 'my flat4'),
  Flat(
      area: 'Wakad',
      bhk: 2,
      possession: DateTime(2023, 3),
      price: 8200000,
      carpetArea: 767, name: 'Mont Vert Sonnet'),
  Flat(
      area: 'Wakad',
      bhk: 2,
      possession: DateTime(2024, 12),
      price: 7700000,
      carpetArea: 787, name: 'AR atlas'),
  Flat(
      area: 'Wakad',
      bhk: 2,
      possession: DateTime(2024, 12),
      price: 8650000,
      carpetArea: 786, name: 'Leela heights'),
  Flat(
      area: 'Wakad',
      bhk: 2,
      possession: DateTime(2024, 1),
      price: 6900000,
      carpetArea: 740, name: 'Plam spring'),
  Flat(
      area: 'Wakad',
      bhk: 2,
      possession: DateTime(2024, 3),
      price: 6300000,
      carpetArea: 692, name: 'Santiago nest'),
  Flat(
      area: 'Wakad',
      bhk: 2,
      possession: DateTime(2025, 12),
      price: 8400000,
      carpetArea: 755, name: '97 sepia'),
  Flat(
      area: 'Wakad',
      bhk: 3,
      possession: DateTime(2024, 25),
      price: 10700000,
      carpetArea: 1058, name: 'Leela heights'),
  Flat(
      area: 'Wakad',
      bhk: 3,
      possession: DateTime(2024, 3),
      price: 15000000,
      carpetArea: 1256, name: 'AR atlas'),
  Flat(
      area: 'Wakad',
      bhk: 3,
      possession: DateTime(2026, 8),
      price: 17000000,
      carpetArea: 1700, name: 'Plam spring'),
  Flat(
      area: 'Wakad',
      bhk: 3,
      possession: DateTime(2024, 12),
      price: 18000000,
      carpetArea: 1900, name: '97 sepia'),
  Flat(
      area: 'Wakad',
      bhk: 1,
      possession: DateTime(2025, 3),
      price: 5000000,
      carpetArea: 500, name: 'Santiago nest'),
  Flat(
      area: 'Wakad',
      bhk: 2,
      possession: DateTime(2027, 3),
      price: 6500000,
      carpetArea: 800, name: 'GK Mirai'),
  Flat(
      area: 'Wakad',
      bhk: 2,
      possession: DateTime(2026, 1),
      price: 7600000,
      carpetArea: 817, name: 'Rahul downtown'),
];
