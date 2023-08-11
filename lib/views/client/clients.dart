import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/constants.dart';

import '../../controller/client.dart';
import '../../model/client.dart';

class ClientsPage extends StatelessWidget {
  var clientsPage = Get.put(ClientsController());

  FloatingActionButton floatingActionButton() => FloatingActionButton.extended(
      onPressed: () {
        Get.toNamed('/clients/add');
      },
      label: Text('Client'),
      icon: Icon(Icons.add));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientsController>(builder: (controller) {
      if (controller.isLoad) {
        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          onRefresh: () async {
            controller.onInit();
          },
          child: ListView.builder(
              itemCount: controller.clients.length,
              itemBuilder: (BuildContext context, int index) {
                return clientContainer(controller.clients.elementAt(index));
              }),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget clientContainer(Clients clients) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: primaryColor200,
      ),
      margin: EdgeInsets.all(6),
      child: ListTile(
        onTap: () {
          Get.toNamed('/client', parameters: {"client_id": clients.id.toString()});
        },
        leading: Icon(Icons.person),
        title: Text('${clients.fname} ${clients.lname}'),
        trailing: Icon(Icons.arrow_forward_ios),
//                         trailing: Icon(
//                           Icons.arrow_forward_ios_outlined,
// // color: Colors.redAccent,
//                         ),
      ));
}
// floatingActionButton: FloatingActionButton.extended(
// onPressed: () {
// Get.toNamed('/clients/add');
// },
// label: Text('Client'),
// icon: Icon(Icons.add)),
// bottomNavigationBar: bottomNavigationBar(index: 2,off: false),
