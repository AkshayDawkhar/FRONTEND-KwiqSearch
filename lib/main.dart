import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeahome/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage());
  }
}

class Room {
  String name;
  int bhk;
  int cp;
  bool amn;
  int price;
  String location;

  Room({required this.name, required this.bhk, required this.cp, required this.amn, required this.price, required this.location});
}
