import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:takeahome/constants.dart';
import 'package:takeahome/model/project.dart';
import '../../controller/project.dart';

class ProjectsPageScaffold extends StatelessWidget {
  var clientsPage = Get.put(Projects2Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Keep the search bar outside of Obx/GetBuilder
          _buildSearchBar(),
          Divider(),
          Expanded(
            // Use Obx only for the parts that need to rebuild, like the project list
            child: Obx(() {
              if (clientsPage.isLoad.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return LiquidPullToRefresh(
                  showChildOpacityTransition: false,
                  onRefresh: () async {
                    await clientsPage.fetchProjects(); // Refresh data
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                        clientsPage.loadMore(); // Load more data on scroll
                      }
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: clientsPage.displayProjects.length,
                      itemBuilder: (BuildContext context, int index) {
                        return projectContainer(clientsPage.displayProjects.elementAt(index));
                      },
                    ),
                  ),
                );
              }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed('/projects/add');
        },
        label: Text('Add Project'),
        icon: Icon(Icons.add),
      ),
    );
  }

  // Search bar function, now outside of Obx/GetBuilder to avoid rebuild
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: clientsPage.searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (s) {
                // Optionally you can trigger search while typing, if needed
              },
              onSubmitted: (s) {
                clientsPage.search(); // Trigger search when user submits the input
              },
            ),
          ),
          TextButton.icon(
            onPressed: () {
              clientsPage.search(); // Trigger search on button press
            },
            icon: Icon(Icons.search),
            label: Text('Search'),
          ),
        ],
      ),
    );
  }

  Widget projectContainer(Projects project) {
    String image = '$HOSTNAME/media/Images/default/0.png';
    if (project.image != null) {
      image = '$HOSTNAME${project.image}';
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: primaryColor200,
      ),
      margin: EdgeInsets.all(6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(image),
          ),
          ListTile(
            onTap: () {
              Get.toNamed('/project', parameters: {"project_id": project.id.toString()});
            },
            leading: Icon(Icons.home_work),
            title: Text('${project.projectName} - ${project.developerName}'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
