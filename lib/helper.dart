import 'dart:convert';

import 'package:http/http.dart' as http;

String HOSTNAME = 'http://192.168.1.43:8000';

Future<int> addProject(Map data) async {
  final url = Uri.parse('$HOSTNAME/home/projects/');
  final responce = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data));
  print(responce.body);
  return 1;
}
