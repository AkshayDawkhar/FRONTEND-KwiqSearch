import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../controller/client.dart';
import '../../model/client.dart';

class ClientsPage extends StatelessWidget {
  var clientsPage = Get.put(ClientsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients'),
      ),
      body: GetBuilder<ClientsController>(builder: (controller) {
        if (controller.isLoad) {
          return LiquidPullToRefresh(
            showChildOpacityTransition: false,
          onRefresh: () async{},
          child: ListView.builder(
                itemCount: controller.clients.length,
                itemBuilder: (BuildContext context, int index) {
                  return clientContainer(controller.clients.elementAt(index));
                }),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed('/clients/add');
          },
          label: Text('Client'),
          icon: Icon(Icons.add)),
    );
  }

  Widget clientContainer(Clients clients) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.deepPurple[100],
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
