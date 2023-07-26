import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed('/projects/add');
          },
          label: Text('Project'),
          icon: Icon(Icons.add)),
    );
  }
}
