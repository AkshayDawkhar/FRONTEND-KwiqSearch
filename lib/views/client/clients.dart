import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed('/clients/add');
          },
          label: Text('Client'),
          icon: Icon(Icons.add)),
    );
  }
}
