import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import your pages
import 'package:takeahome/views/client/add.dart';
import 'package:takeahome/views/client/client_page.dart';
import 'package:takeahome/views/client/clients.dart';
import 'package:takeahome/views/client/search_page.dart';
import 'package:takeahome/views/editprofile.dart';
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
import 'package:takeahome/views/profile_page.dart';
import 'package:takeahome/views/splash_screen.dart'; // Import Profile Page

// Define your primary color
const Color primaryColor = Colors.blue; // Update this with your actual primary color

// Function to get the initial route
Future<String> getInitialRoute() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  if (token != null) {
    return '/home';
  } else {
    return '/login';
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getInitialRoute(),
      builder: (context, snapshot) {
        // Show a loading spinner while the initial route is being determined
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        // Handle the error if necessary
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        }

        // Return the GetMaterialApp with the determined initial route
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            useMaterial3: true,
          ),
          initialRoute: '/splash',
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
            GetPage(name: '/login', page: () => Login(), title: 'Login'),
            GetPage(name: '/profile', page: () => ProfilePage(), title: 'Profile'),
            GetPage(name: '/edit-profile', page: () => EditProfilePage(), title: 'Edit Profile'),
            GetPage(name: '/splash', page: () => SplashScreen()),
            // Add other pages here
          ],
        );
      },
    );
  }
}

// Define your tabs
const List<Tab> tabs = <Tab>[
  Tab(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.home),
        SizedBox(height: 2),
        Text('Home'),
      ],
    ),
  ),
  Tab(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.home_work),
        SizedBox(height: 2),
        Text('Project'),
      ],
    ),
  ),
  Tab(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.supervised_user_circle),
        SizedBox(height: 2),
        Text('Client'),
      ],
    ),
  ),
  Tab(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.person),
        SizedBox(height: 2),
        Text('Profile'),
      ],
    ),
  ),
];

class TabControllerExample extends StatefulWidget {
  @override
  State<TabControllerExample> createState() => _TabControllerExampleState();
}

class _TabControllerExampleState extends State<TabControllerExample> {
  HomePage homePage = HomePage();
  ProjectsPage projectsPage = ProjectsPage();
  ClientsPage clientsPage = ClientsPage();
  ProfilePage profilePage = ProfilePage();

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
          icon: Icon(Icons.add),
        );
      case 2:
        return clientsPage.floatingActionButton();

      case 3:
        return profilePage.floatingActionButton();
      default:
        return FloatingActionButton(onPressed: () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            setState(() {});
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: Text(['Home', 'Projects', 'Clients', 'Profile'].elementAt(tabController.index)),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed('/clients/add');
                },
                icon: Icon(Icons.person_add_alt),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed('/notifications');
                },
                icon: Icon(Icons.notifications),
              ),
            ],
          ),
          body: TabBarView(
            children: [homePage, projectsPage, clientsPage, profilePage],
          ),
          floatingActionButton: _getFabForTab(tabController.index),
          bottomNavigationBar: TabBar(
            enableFeedback: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 0.1,
            indicatorPadding: EdgeInsets.all(0),
            tabs: tabs,
          ),
        );
      }),
    );
  }
}
