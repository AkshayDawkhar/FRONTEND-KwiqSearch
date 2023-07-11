import '../model/room.dart';

List<Room> rooms = [
  Room(name: 'name', number: 12, loc: 'pune',bhk: 0.5),
  Room(name: 'name1', number: 13, loc: 'pune1',bhk: 2),
  Room(name: 'name2', number: 14, loc: 'pune',bhk: 2),
  Room(name: 'name3', number: 15, loc: 'pune1',bhk: 1),
  Room(name: 'name4', number: 16, loc: 'pune',bhk: 3),
  Room(name: 'name5', number: 17, loc: 'pune',bhk: 2),
  Room(name: 'name6', number: 18, loc: 'pune1',bhk: 1),
  Room(name: 'name7', number: 19, loc: 'pune',bhk: 1),
  Room(name: 'name8', number: 90, loc: 'pune',bhk: 1),
  Room(name: 'name9', number: 19, loc: 'pune1',bhk: 1.5),
];

List<Room> filterRooms({String? name, int? number, String? loc,double? bhk}) {
  return rooms
      .where((room) => room.number < number!)
      .where((room) => loc == null || room.loc == loc)
      .where((room) => bhk == null || room.bhk == bhk)
      .toList();
  // return [];
}
