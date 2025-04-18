import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String HOSTNAME = 'http://143.244.139.72:25000';
String DEPLOY = 'http://ec2-65-1-248-145.ap-south-1.compute.amazonaws.com:8080';
String LOCAL = HOSTNAME;

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
List<String> amenities = ['All Amenities', 'No Amenities', 'Basic Amenities', 'EV charging point'];
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
  'Town Ship',
  'R Zone',
  'Agriculture Plot',
];
List<String> projectCategory = [
  'New launch',
  'Resale',
  'Under construction',
  'Pre Launch',
];
List<int> years = [2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 3036, 2037];
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

String convertToCamelCase(String input) {
  List<String> words = input.split(' ');
  String result = '';

  for (String word in words) {
    result += word.toLowerCase();
  }

  return result;
}

bool getMatch(List<String> values, String query) {
  query = convertToCamelCase(query);
  for (String value in values) {
    if (convertToCamelCase(value).startsWith(query)) {
      return true;
    }
  }
  return false;
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

String dateToString(DateTime dateTime) {
  return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
}

String formatTime(DateTime dateTime) {
  String period = 'AM';
  int hour = dateTime.hour;
  int minute = dateTime.minute;

  if (hour >= 12) {
    period = 'PM';
    if (hour > 12) {
      hour -= 12;
    }
  }

  String hourStr = hour.toString().padLeft(2, '0');
  String minuteStr = minute.toString().padLeft(2, '0');

  return '$hourStr:$minuteStr $period';
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  String period = 'AM';
  int hour = timeOfDay.hour;
  int minute = timeOfDay.minute;

  if (hour >= 12) {
    period = 'PM';
    if (hour > 12) {
      hour -= 12;
    }
  }
  String hourStr = hour.toString().padLeft(2, '0');
  String minuteStr = minute.toString().padLeft(2, '0');

  return '$hourStr:$minuteStr $period';
}

IconData getActionIcon(String action) {
  if (action == 'call') {
    return Icons.call;
  } else if (action == 'message') {
    return Icons.message;
  } else {
    return Icons.home_work;
  }
}

String numberToLCr(double number) {
  if (number < 100000) {
    return '${(number / 1000).toStringAsFixed(0)}K';
  } else if (number >= 100000 && number < 10000000) {
    return '${(number / 100000).toStringAsFixed(1)}L';
  } else {
    return '${(number / 10000000).toStringAsFixed(2)}Cr';
  }
}

int getAmenitiesNumebr(String amenities) {
  switch (amenities) {
    case 'no amenities':
      return 0;
    case 'basic amenities':
      return 1;
    case 'all amenities':
      return 2;
  }
  return 0;
}

final validPhoneNumberRegExp = RegExp(r'^\d{10}$'); // 10 digits, all numeric
  String unitToName(double unit) {
  if (unit < 1) {
    switch (unit) {
      case 0.0:
        return 'N/A Plot';
      case 0.1:
        return 'Custom Office';
      case 0.2:
        return 'Custom Shop';
    }
  } else {
    return '$unit BHK';
  }
  return '';
}

String monthDate(DateTime dateTime) {
  return '${getMonthName(dateTime.month)} ${dateTime.year}';
}

String getMonthName(int monthNumber) {
  switch (monthNumber) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "-";
  }
}

Color primaryColor = Colors.blue;
Color primaryColor100 = Colors.blue[100]!;
Color primaryColor200 = Colors.blue[200]!;

void getErrorDialog(String data) {
  Map<String, dynamic> message = jsonDecode(data);
  Get.dialog(AlertDialog(
    backgroundColor: Colors.redAccent[100],
    title: Text('Error'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var entry in message.entries)
          Text(
            '${entry.key} ${entry.value.first}',
            style: TextStyle(fontSize: 18),
          ),
      ],
    ),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'))
    ],
  ));
}

class MyRout {
  MyRout({required this.name, required this.url});

  String name;
  String url;
}

List<MyRout> routs = [
  MyRout(name: 'Home', url: '/home'),
  MyRout(name: 'Project', url: '/projects'),
  MyRout(name: 'Client', url: '/clients'),
];
Future<void> Logout() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');

  if (token != null) {
    try {
      final response = await http.post(
        Uri.parse('$HOSTNAME/organization/logout/'),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 401) {
        await prefs.remove('auth_token');
        Get.offAllNamed('/login');
      } else {
        Get.snackbar('Error', 'Logout failed. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again.');
    }
  } else {
    Get.snackbar('Error', 'No user is logged in.');
  }
}

// final prefs = await SharedPreferences.getInstance();
// a= prefs.getString('auth_token');
// create a function to get the token and configure the headers
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

Map<String, String> getHeaders() {
  var t = getToken();
  return {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Token $t'
  };
}