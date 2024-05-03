import 'package:WallpaperHaven/model/photosModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:WallpaperHaven/controller/apioperation.dart';
import 'package:WallpaperHaven/views/widgets/CustomAppBar.dart';
import 'package:WallpaperHaven/views/widgets/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List<PhotosModel> trendingWallList;


GetTrendingWallpapers() async{
  trendingWallList = await ApiOperation.getTrendingWallpapers();

  setState(() {

  });
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetTrendingWallpapers();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SearchBar()),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 30,
                    itemBuilder: ((context, index) => Category())),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 400,
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                ),
                itemCount: trendingWallList.length,
                itemBuilder: (context, index) => GridTile(
                  child: Container(
                    height: 800,
                    width: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          height: 800,
                          width: 50,
                          fit: BoxFit.cover,
                          trendingWallList[index].imgSrc),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
