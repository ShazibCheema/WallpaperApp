import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiOperation{
  
  static getTrendingWallpapers() async{
    await http.get(
        Uri.parse("https://api.pexels.com/v1/curated"),
      headers: {"Authorization" : "5Twn3kOToszHFkEvIPjgVwCXna989OEBFmqEV76y9bRXQYk7ATLky4KQ"}
    ).then((value){

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        Map<String, dynamic> src = element["src"];
        print(src["portrait"]);
      });
    });
  }
}

