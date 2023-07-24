import 'package:flutter/material.dart';

List<String> places = [
  'Mamurdi',
  'Gahunje',
  'Kiwale',
  'Ravet',
  'Akurdi',
  'Punawale',
  'Tathawade',
  'Kasarsai',
  'Wakad',
  'Marunji',
  'Hinjawadi Phase 1',
  'Hinjawadi Phase 2',
  'Hinjawadi Phase 3',
  'Pimple Saudagar',
  'Pimple Gurav',
  'New Sanghavi',
  'Pimple Nilakh',
  'Balewadi',
  'Baner',
  'Sus',
  'Mahalunge',
  'Pashan',
  'Bavdhan',
  'Warje',
  'Kothrud',
  'Aundh'
];
List<String> areaIn = ['PMRDA', 'PCMC', 'PMC'];
List<DropdownMenuItem<double>> bhks = const [
  DropdownMenuItem<double>(
    value: 0.5,
    child: Text('RK'),
  ),
  DropdownMenuItem<double>(
    value: 0.0,
    child: Text('Plot'),
  ),
  DropdownMenuItem<double>(
    value: 0.1,
    child: Text('Custom office '),
  ),
  DropdownMenuItem<double>(
    value: 0.2,
    child: Text('Custom shop'),
  ),
  DropdownMenuItem<double>(
    value: 1,
    child: Text('1 BHK'),
  ),
  DropdownMenuItem<double>(
    value: 1.5,
    child: Text('1.5 BHK'),
  ),
  DropdownMenuItem<double>(
    value: 2,
    child: Text('2 BHK'),
  ),
  DropdownMenuItem<double>(
    value: 2.5,
    child: Text('2.5 BHK'),
  ),
  DropdownMenuItem<double>(
    value: 3,
    child: Text('3 BHK'),
  ),
  DropdownMenuItem<double>(
    value: 3.5,
    child: Text('3.5 BHK'),
  ),
  DropdownMenuItem<double>(
    value: 4,
    child: Text('4 BHK'),
  ),
  DropdownMenuItem<double>(
    value: 4.5,
    child: Text('4.5 BHK'),
  ),
  DropdownMenuItem<double>(
    value: 5,
    child: Text('5 BHK'),
  ),
  DropdownMenuItem<double>(
    value: 5.5,
    child: Text('5.5 BHK'),
  ),
  DropdownMenuItem<double>(
    value: 6,
    child: Text('6 BHK'),
  ),
];
List<String> amenities = [
  'All Amenities',
  'No Amenities',
  'Basic Amenities',
  'EV charging point'
];
List<String> waterConnection = [
  'PCMC',
  'PMRDA',
  'PMC',
  'Borewell',
  'Other',
];
List<String> parking = [
  'covered',
  'Open car park',
  'Semi covered car park',
  'Common car park',
  'Without car park',
];
List<String> projectType = [
  'Stand Alone Building',
  'Multiple Wings',
  'N/A Plot',
  'Town Sheep',
];
List<int> years = [
  2023,
  2024,
  2025,
  2026,
  2027,
  2028,
  2029,
  2030,
  2031,
  2032,
  2033,
  2034,
  2035,
  3036,
  2037
];
final List<DropdownMenuItem<int>> months = [
  DropdownMenuItem(
    value: 1,
    child: Text('January'),
  ),
  DropdownMenuItem(
    value: 2,
    child: Text('February'),
  ),
  DropdownMenuItem(
    value: 3,
    child: Text('March'),
  ),
  DropdownMenuItem(
    value: 4,
    child: Text('April'),
  ),
  DropdownMenuItem(
    value: 5,
    child: Text('May'),
  ),
  DropdownMenuItem(
    value: 6,
    child: Text('June'),
  ),
  DropdownMenuItem(
    value: 7,
    child: Text('July'),
  ),
  DropdownMenuItem(
    value: 8,
    child: Text('August'),
  ),
  DropdownMenuItem(
    value: 9,
    child: Text('September'),
  ),
  DropdownMenuItem(
    value: 10,
    child: Text('October'),
  ),
  DropdownMenuItem(
    value: 11,
    child: Text('November'),
  ),
  DropdownMenuItem(
    value: 12,
    child: Text('December'),
  ),
];

class Locations {
  double latitude;
  double longitude;

  Locations(this.latitude, this.longitude);
}

List<Locations> locations = [
  Locations(18.604925, 73.746217),
  Locations(18.583439, 73.770803),
  Locations(18.569013, 73.779474),
  Locations(18.579787, 73.785909),
  Locations(18.575884, 73.789953),
  Locations(18.568692, 73.791328),
  Locations(18.549689, 73.789972),
  Locations(18.549596, 73.791682),
];
