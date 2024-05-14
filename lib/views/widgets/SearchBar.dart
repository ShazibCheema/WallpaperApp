import 'dart:convert';

import 'package:WallpaperHaven/views/screens/Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class searchbar extends StatefulWidget {
  searchbar({super.key});

  @override
  State<searchbar> createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  List data = []; // Initialize empty list
  TextEditingController searchImage = TextEditingController();

  getphoto(search) async {
    setState(() {
      data = [];
    });

    try {
      final url = Uri.parse(
          "https://api.pexels.com/v1/search?query=$search&per_page=30&page=1");
      var response = await http.get(url);
      var result = jsonDecode(response.body);

      data = result['results'];
      print(data);

      setState(() {});

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: searchImage,
                decoration: InputDecoration(
                  hintText: 'Search For Free Wallpapers...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.orangeAccent,
            iconSize: 30,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                  SearchScreen(query: searchImage.text)));
            },
          ),
        ],
      ),
    );
  }
}
