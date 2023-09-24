import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/views/client/add.dart';
import 'package:takeahome/views/client/client_page.dart';
import 'package:takeahome/views/client/clients.dart';
import 'package:takeahome/views/client/search_page.dart';
import 'package:takeahome/views/home_page.dart';
import 'package:takeahome/views/login.dart';
import 'package:takeahome/views/map_page.dart';
import 'package:takeahome/views/notifications.dart';
import 'package:takeahome/views/project/add.dart';
import 'package:takeahome/views/project/edit_project.dart';
import 'package:takeahome/views/project/image.dart';
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
      initialRoute: '/login',
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
        GetPage(name: '/project/edit', page: () => EditProject()),
        GetPage(name: '/project', page: () => ProjectPage()),
        GetPage(name: '/map', page: () => MapPage()),
        GetPage(name: '/notifications', page: () => NotificationsPage(), title: 'notifications'),
        GetPage(name: '/interested', page: () => InterestedPage(), title: 'interested'),
        GetPage(name: '/image', page: () => ImagePage(), title: 'interested'),
        GetPage(name: '/login', page: () => Login(), title: 'interested'),
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
  Tab(

    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.home),
        SizedBox(height: 2,),
        Text('Home')
      ],
    ),
  ),
  Tab(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.home_work),
        SizedBox(height: 2,),
        Text('Project')
      ],
    ),
  ),
  Tab( child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(Icons.person),
      SizedBox(height: 2,),
      Text('Client')
    ],
  ),
  ),
  // Tab(text: 'First'),
  // Tab(text: 'Second'),
];

class TabControllerExample extends StatefulWidget {
  @override
  State<TabControllerExample> createState() => _TabControllerExampleState();
}

class _TabControllerExampleState extends State<TabControllerExample> {
  HomePage homePage = HomePage();

  ProjectsPage projectsPage = ProjectsPage();

  ClientsPage clientsPage = ClientsPage();

  Widget _getFabForTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return homePage.floatingActionButton();
      case 1:
        return FloatingActionButton.extended(
            onPressed: () {
              Get.toNamed('/projects/add');
            },
            label: Text('Project'),
            icon: Icon(Icons.add));
      case 2:
        return clientsPage.floatingActionButton();
      default:
        return FloatingActionButton(onPressed: () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            setState(() {});
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: Text(['Home', 'Projects', 'Clients'].elementAt(tabController.index)),
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
            ],
            // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            // backgroundColor: Colors.,
          ),
          // AppBar(
          //   bottom: const TabBar(
          //     tabs: tabs,
          //   ),
          // ),
          body: TabBarView(children: [homePage, projectsPage, clientsPage]),
          floatingActionButton: _getFabForTab(tabController.index),
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
