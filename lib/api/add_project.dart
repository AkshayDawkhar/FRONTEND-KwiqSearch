import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
Future<int> ret(Map data) async {
  final url = Uri.parse('$HOSTNAME/home/projects');
  final responce = await http.post(url,
  headers: <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  },
  body: jsonEncode(data));
  print('responce.body');
  print(responce.body);
  return 1;
}
