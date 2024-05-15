import 'dart:convert';
import 'package:WallpaperHaven/model/categoryModel.dart';
import 'package:WallpaperHaven/model/photosModel.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpapersList = [];
  static List<CategoryModel> cateogryModelList = [];

  static String _apiKey =
      "5Twn3kOToszHFkEvIPjgVwCXna989OEBFmqEV76y9bRXQYk7ATLky4KQ";
  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?page=1&per_page=40"),
        headers: {"Authorization": "$_apiKey"}).then((value) {
      
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        trendingWallpapers.add(PhotosModel.fromAPI2App(element));
      });
    });

    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {"Authorization": "$_apiKey"}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      photos.forEach((element) {
        searchWallpapersList.add(PhotosModel.fromAPI2App(element));
      });
    });

    return searchWallpapersList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Gaming",
      "Bikes",
      "Street",
      "City",
      "Plants",
      "Abstract",
      "Animal"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((categoryName) async {
      final _random = new Random();

      PhotosModel photoModel =
      (await searchWallpapers(categoryName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      cateogryModelList
          .add(CategoryModel(categoryImgUrl: photoModel.imgSrc, categoryName: categoryName));
    });

    return cateogryModelList;
  }
}

