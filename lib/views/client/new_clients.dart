// lib/client_list_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClientListPage extends StatefulWidget {
  @override
  _ClientListPageState createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  final String apiUrl = "http://127.0.0.1:8000/client/clients/?limit=1";
  List clients = [];
  bool loading = false;
  String? nextUrl;
  String? prevUrl;

  @override
  void initState() {
    super.initState();
    fetchClients(apiUrl);
  }

  Future<void> fetchClients(String url) async {
    setState(() {
      loading = true;
    });

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        clients = jsonResponse['results'];
        nextUrl = jsonResponse['next'];
        prevUrl = jsonResponse['previous'];
        loading = false;
      });
    } else {
      throw Exception('Failed to load clients');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client List'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: clients.length,
              itemBuilder: (context, index) {
                var client = clients[index];
                return ListTile(
                  title: Text('${client['fname']} ${client['lname']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone: ${client['phoneNO']}'),
                      Text('Email: ${client['email']}'),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: prevUrl != null
                    ? () {
                  fetchClients(prevUrl!);
                }
                    : null,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: nextUrl != null
                    ? () {
                  fetchClients(nextUrl!);
                }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
