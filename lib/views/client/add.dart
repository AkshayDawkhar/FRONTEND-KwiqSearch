import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddClientPage extends StatelessWidget {
  const AddClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Client'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
          },
          label: Text('Save'),
          icon: Icon(Icons.done)),
    );
  }
}
