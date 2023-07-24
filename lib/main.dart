import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeahome/views/add_project.dart';
import 'package:takeahome/views/client_page.dart';
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
      home: HomePage(),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/add-project', page: () => AddProject()),
        GetPage(name: '/client-page', page: () => ClientPage()),

        // GetPage(name: '/about', page: () => AboutPage()),
      ],
    );
  }
}

// class Room {
//   String name;
//   int bhk;
//   int cp;
//   bool amn;
//   int price;
//   String location;
//
//   Room({required this.name, required this.bhk, required this.cp, required this.amn, required this.price, required this.location});
// }
