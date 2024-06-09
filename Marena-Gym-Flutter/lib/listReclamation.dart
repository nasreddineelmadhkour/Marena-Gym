import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetfe/Models/StaticUser.dart';
import 'package:projetfe/Netwrok/BaseURL.dart';


class ListReclamation extends StatefulWidget {
  @override
  _ListReclamation createState() => _ListReclamation();
}

class _ListReclamation extends State<ListReclamation> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String apiUrl = BaseURL.baseURL + '/api/reclamation/allReclamation/${StaticUser.staticUser2.id}';

    print(apiUrl);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${StaticUser.staticLogin.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reclamation'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            title: Text("- Reclamation : "
            +item['contenu'] ?? '',style: TextStyle(color: Colors.black,fontSize: 20)),
            subtitle: Text("-> Reponse admin :"
            +item['reponcereclamations'] ?? '',style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.bold)),
          );
        },
      ),
    );
  }
}
