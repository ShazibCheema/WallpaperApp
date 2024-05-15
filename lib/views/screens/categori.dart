import 'package:WallpaperHaven/controller/apioperation.dart';
import 'package:WallpaperHaven/model/photosModel.dart';
import 'package:WallpaperHaven/views/screens/fullScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:WallpaperHaven/views/widgets/CustomAppBar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoryScreen extends StatefulWidget {
  String categoryName;
  String CategoryImgUrl;
  CategoryScreen(
      {super.key, required this.CategoryImgUrl, required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<PhotosModel> categoryResults;
  bool isloading = true;
  GetCatRelwall() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.categoryName);
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    GetCatRelwall();
    super.initState();
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
      body: isloading
          ? Center(child: SpinKitCircle(color: Colors.amberAccent,),)
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          widget.CategoryImgUrl),
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black38,
                      ),
                      Positioned(
                        left: 180,
                        top: 40,
                        child: Column(
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              widget.categoryName,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 800,
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 400,
                          crossAxisCount: 2,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: categoryResults.length,
                        itemBuilder: (context, index) => GridTile(
                                child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreen(
                                            imgPath: categoryResults[index]
                                                .imgSrc)));
                              },
                              child: Hero(
                                tag: categoryResults[index].imgSrc,
                                child: Container(
                                  height: 800,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                        height: 800,
                                        width: 50,
                                        fit: BoxFit.cover,
                                        categoryResults[index].imgSrc),
                                  ),
                                ),

                              ),
                            ))),
                  ),
                ],
              ),
            ),
    );
  }
}
