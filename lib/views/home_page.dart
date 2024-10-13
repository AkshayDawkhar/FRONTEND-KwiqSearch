import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../controller/ProfileController.dart';

class ProfileHomePage extends StatelessWidget {

  FloatingActionButton floatingActionButton() => FloatingActionButton.extended(
      onPressed: () {
        Get.toNamed('/edit-profile');
      },
      label: Text('Edit'),
      icon: Icon(Icons.add)
  );

  @override
  Widget build(BuildContext context) {
    return  LiquidPullToRefresh(child:
        // Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(100.0),
        //       child: Text('data'),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(100.0),
        //       child: Text('data'),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(100.0),
        //       child: Text('data'),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(100.0),
        //       child: Text('data'),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(100.0),
        //       child: Text('data'),
        //     ),
        //   ],
        // )
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text('data'),
            ),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text('data'),
            ),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text('data'),
            ),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text('data'),
            ),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text('data'),
            ),            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text('data'),
            ),            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text('data'),
            ),            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text('data'),
            ),
          ],
        ),
        onRefresh: () async {
          // controller.onInit();
        }
    );
  }

  // Profile Header Section


}
