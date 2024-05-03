import 'dart:convert';
import 'package:WallpaperHaven/model/photosModel.dart';
import 'package:http/http.dart' as http;

class ApiOperation{
  static List<PhotosModel> trendingWallpapers = [];
  static Future<List<PhotosModel>> getTrendingWallpapers() async{

    await http.get(
        Uri.parse("https://api.pexels.com/v1/curated"),
      headers: {"Authorization" : "5Twn3kOToszHFkEvIPjgVwCXna989OEBFmqEV76y9bRXQYk7ATLky4KQ"}
    ).then((value){

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        trendingWallpapers.add(PhotosModel.fromAPI2App(element));
      });
    });

    return trendingWallpapers;
  }
}

