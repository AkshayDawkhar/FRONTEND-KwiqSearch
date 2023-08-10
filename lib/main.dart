import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/views/client/add.dart';
import 'package:takeahome/views/client/client_page.dart';
import 'package:takeahome/views/client/clients.dart';
import 'package:takeahome/views/client/search_page.dart';
import 'package:takeahome/views/home_page.dart';
import 'package:takeahome/views/map_page.dart';
import 'package:takeahome/views/notifications.dart';
import 'package:takeahome/views/project/add.dart';
import 'package:takeahome/views/project/interested.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
        // appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[50])
      ),
      // home: HomePage(),
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/home', page: () => TabControllerExample()),
        GetPage(name: '/search', page: () => SearchPage()),
        GetPage(name: '/add-project', page: () => AddProject()),
        GetPage(name: '/clients', page: () => ClientsPage()),
        GetPage(name: '/clients/add', page: () => AddClientPage()),
        GetPage(name: '/client', page: () => ClientPage()),
        GetPage(name: '/projects', page: () => ProjectsPage()),
        GetPage(name: '/projects/add', page: () => AddProject()),
        GetPage(name: '/project', page: () => ProjectPage()),
        GetPage(name: '/map', page: () => MapPage()),
        GetPage(name: '/notifications', page: () => NotificationsPage(), title: 'notifications'),
        GetPage(name: '/interested', page: () => InterestedPage(), title: 'interested'),

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



const List<Tab> tabs = <Tab>[
  Tab(icon: Icon(Icons.home),iconMargin: EdgeInsets.all(0),),
  Tab(icon: Icon(Icons.home_work),iconMargin: EdgeInsets.all(2),),
  Tab(icon: Icon(Icons.person),iconMargin: EdgeInsets.all(2),),
  // Tab(text: 'First'),
  // Tab(text: 'Second'),
];

class TabControllerExample extends StatelessWidget {
  const TabControllerExample({super.key});

  @override
  Widget build(BuildContext context) {
    HomePage homePage = HomePage();
    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.toNamed('/clients/add');
                  },
                  icon: Icon(Icons.person_add_alt)),
              IconButton(
                  onPressed: () {
                    Get.toNamed('/notifications');
                  },
                  icon: Icon(Icons.notifications)),
              // IconButton(
              //     onPressed: () {
              //       // filterController.setDefault();
              //     },
              //     icon: Icon(Icons.close))
              // PopupMenuButton(itemBuilder: (context) {
              //   return [
              //     PopupMenuItem<int>(
              //       value: 0,
              //       child: ListTile(
              //         leading: Icon(Icons.person),
              //         // iconColor: Colors.blueAccent,
              //         // textColor: Colors.blueAccent,
              //         title: Text('Clients'),
              //       ),
              //     ),
              //     PopupMenuItem<int>(
              //       value: 1,
              //       child: ListTile(
              //         leading: Icon(Icons.home_work),
              //         // iconColor: Colors.greenAccent,
              //         // textColor: Colors.greenAccent,
              //         title: Text('Projects'),
              //       ),
              //     ),
              //   ];
              // }, onSelected: (value) {
              //   if (value == 0) {
              //     Get.toNamed('/clients');
              //     // print("Done");
              //   } else if (value == 1) {
              //     Get.toNamed('/projects');
              //     // print("Work");
              //   } else if (value == 2) {
              //     print("Delete");
              //   }
              // })
            ],
            // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            // backgroundColor: Colors.,
          ),
          // AppBar(
          //   bottom: const TabBar(
          //     tabs: tabs,
          //   ),
          // ),
          body: TabBarView(
            children: [
              homePage,
              ProjectsPage(),
              ClientsPage(),
            ]
          ),
          floatingActionButton:homePage.floatingActionButton(),
              // FloatingActionButton(
              //   heroTag: null,
              //   onPressed: () {
              //     Get.toNamed('/map', arguments: {"filteredList": [] , "units": []});
              //   },
              //   child: Icon(Icons.location_on),
              // ),
          bottomNavigationBar: TabBar(
            enableFeedback: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 0.1,
            indicatorPadding: EdgeInsets.all(0),
            tabs: tabs,
          ),
          // bottomSheet: TabBar(
          //   tabs: tabs,
          // ),
        );
      }),
    );
  }
}
