import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeahome/views/client/add.dart';
import 'package:takeahome/views/client/client_page.dart';
import 'package:takeahome/views/client/clients.dart';
import 'package:takeahome/views/home_page.dart';
import 'package:takeahome/views/map_page.dart';
import 'package:takeahome/views/project/add.dart';
import 'package:takeahome/views/project/project_page.dart';
import 'package:takeahome/views/project/projects.dart';

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
      // home: HomePage(),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/add-project', page: () => AddProject()),
        GetPage(name: '/clients', page: () => ClientsPage()),
        GetPage(name: '/clients/add', page: () => AddClientPage()),
        GetPage(name: '/client', page: () => ClientPage()),
        GetPage(name: '/projects', page: () => ProjectsPage()),
        GetPage(name: '/projects/add', page: () => AddProject()),
        GetPage(name: '/project', page: () => ProjectPage()),
        GetPage(name: '/map', page: () => MapPage()),

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
