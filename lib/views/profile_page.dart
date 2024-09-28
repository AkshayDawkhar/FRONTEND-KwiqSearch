import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../controller/ProfileController.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  FloatingActionButton floatingActionButton() => FloatingActionButton.extended(
      onPressed: () {
        Get.toNamed('/edit-profile');
      },
      label: Text('Edit'),
      icon: Icon(Icons.add)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
      //   backgroundColor: Colors.blue[800],
      //   leading: Builder(
      //     builder: (context) => IconButton(
      //       icon: Icon(Icons.menu, color: Colors.white),
      //       onPressed: () {
      //         Scaffold.of(context).openDrawer();
      //       },
      //     ),
      //   ),
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue[800],
      //         ),
      //         child: Obx(() {
      //           if (profileController.isLoading.value) {
      //             return Center(child: CircularProgressIndicator());
      //           } else {
      //             return Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 CircleAvatar(
      //                   radius: 30,
      //                   backgroundColor: Colors.white,
      //                   child: Icon(Icons.person, size: 30, color: Colors.blue[800]),
      //                 ),
      //                 SizedBox(height: 10),
      //                 Text(
      //                   profileController.name.value,
      //                   style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
      //                 ),
      //                 Text(
      //                   profileController.email.value,
      //                   style: TextStyle(color: Colors.white70, fontSize: 16),
      //                 ),
      //               ],
      //             );
      //           }
      //         }),
      //       ),
      //       _buildDrawerItem(Icons.edit, 'Edit Profile', () {
      //         Get.toNamed('/edit-profile');
      //       }),
      //       _buildDrawerItem(Icons.logout, 'Logout', () {
      //         Navigator.of(context).pop();
      //         // Implement logout functionality here
      //       }),
      //     ],
      //   ),
      // ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return LiquidPullToRefresh(
            showChildOpacityTransition: false,
            onRefresh: () async {
              await profileController.fetchProfile();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    SizedBox(height: 20),
                    _buildProfileDetailsCard(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  // Profile Header Section
  Widget _buildProfileHeader() {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue[800],
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileController.name.value,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                ),
                SizedBox(height: 2),
                Text(
                  profileController.email.value,
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),

      ],
    );
  }

  // Profile Details in a Card
  Widget _buildProfileDetailsCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileDetailRow('User Type', profileController.userType.value),
            Divider(color: Colors.grey[300]),
            _buildProfileDetailRow('Organization', profileController.organization.value),
            Divider(color: Colors.grey[300]),
            _buildProfileDetailRow('Phone number', profileController.phoneNumber.value),
            Divider(color: Colors.grey[300]),
            _buildProfileDetailRow('Locality', profileController.locality.value),
            Divider(color: Colors.grey[300]),
            _buildProfileDetailRow('Assigned To', profileController.assignedTo.value),
          ],
        ),
      ),
    );
  }

  // Profile Detail Row
  Widget _buildProfileDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blue[900]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // Drawer Item
  Widget _buildDrawerItem(IconData icon, String title, Function() onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[800]),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
