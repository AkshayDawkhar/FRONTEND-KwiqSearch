import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:takeahome/constants.dart';

class ClientsController extends GetxController {
  var displayClients = <dynamic>[].obs; // Observable list
  var isLoad = true.obs;
  var isLoadingMore = false.obs; // Observable for loading more data
  var nextUrl = ''.obs; // Store the next page URL as observable
  var searchController = TextEditingController();
  var searchQuery = ''.obs; // Observable for search query

  @override
  void onInit() {
    super.onInit();
    fetchClients(); // Initial fetch of clients
  }

  // Fetch token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Fetch clients with pagination and search query support
  void fetchClients({String? url, String? searchQuery}) async {
    isLoad(true);
    try {
      final token = await getToken(); // Get the token
      if (token == null) {
        // Handle token not found error
        isLoad(false);
        return;
      }

      String apiUrl = url ?? '$HOSTNAME/client/clients/?limit=10';
      if (searchQuery != null && searchQuery.isNotEmpty) {
        apiUrl += '&search_query=$searchQuery'; // Add search query to the URL
      }
      final response = await http.get(Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Token $token', // Pass the token in headers
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        displayClients.value = data['results']; // Replace the list with new data
        nextUrl.value = data['next'] ?? ''; // Update next URL
      }
    } finally {
      isLoad(false);
    }
  }

  // Load more clients when the user scrolls to the bottom
  void loadMoreClients() async {
    if (nextUrl.value.isEmpty || isLoadingMore.value) return;
    isLoadingMore(true);

    try {
      final token = await getToken(); // Get the token for loading more
      if (token == null) {
        isLoadingMore(false);
        return;
      }
      final response = await http.get(Uri.parse(nextUrl.value),
        headers: {
          'Authorization': 'Token $token', // Pass the token in headers
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        displayClients.addAll(data['results']); // Append new clients to the list
        nextUrl.value = data['next'] ?? ''; // Update next URL
      }
    } finally {
      isLoadingMore(false);
    }
  }

  // Perform search by fetching clients with the search query
  void search() {
    fetchClients(searchQuery: searchController.text); // Fetch clients based on search query
  }
}

class ClientsPage extends StatelessWidget {
  final clientsPage = Get.put(ClientsController());
  final ScrollController _scrollController = ScrollController(); // Scroll controller for pagination

  ClientsPage() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        clientsPage.loadMoreClients(); // Load more when scrolled to the bottom
      }
    });
  }

  FloatingActionButton floatingActionButton() => FloatingActionButton.extended(
    onPressed: () {
      Get.toNamed('/clients/add');
    },
    label: Text('Client'),
    icon: Icon(Icons.add),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() { // Use Obx for automatic UI updates
      if (clientsPage.isLoad.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return LiquidPullToRefresh(
          showChildOpacityTransition: false,
          onRefresh: () async {
            clientsPage.onInit();
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Search'),
                        controller: clientsPage.searchController,
                        onChanged: (s) {
                          // Optionally: Trigger search on typing
                        },
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        clientsPage.search(); // Trigger search on button click
                      },
                      icon: Icon(Icons.search),
                      label: Text('Search'),
                    )
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController, // Attach the scroll controller
                  itemCount: clientsPage.displayClients.length + 1, // Add 1 for the loading indicator
                  itemBuilder: (BuildContext context, int index) {
                    if (index == clientsPage.displayClients.length) {
                      // Show loading indicator at the bottom if still loading more clients
                      return clientsPage.isLoadingMore.value
                          ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                          : SizedBox.shrink();
                    }
                    return clientContainer(clientsPage.displayClients[index]);
                  },
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  Widget clientContainer(dynamic client) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.blue.shade200,
    ),
    margin: EdgeInsets.all(6),
    child: ListTile(
      onTap: () {
        Get.toNamed('/client', parameters: {"client_id": client['id'].toString()});
      },
      leading: Icon(Icons.person),
      title: Text('${client['fname']} ${client['lname']}'),
      trailing: Icon(Icons.arrow_forward_ios),
    ),
  );
}
