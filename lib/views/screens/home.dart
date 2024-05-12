import 'package:WallpaperHaven/model/categoryModel.dart';
import 'package:WallpaperHaven/model/photosModel.dart';
import 'package:WallpaperHaven/views/screens/fullScreen.dart';
import 'package:WallpaperHaven/views/widgets/SearchBar.dart';
import 'package:WallpaperHaven/views/widgets/categoryBlock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:WallpaperHaven/controller/apioperation.dart';
import 'package:WallpaperHaven/views/widgets/CustomAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List<PhotosModel> trendingWallList;
  late List<CategoryModel> CatModList;
  bool isloading = true;

  GetCategoryDetails() async{
    CatModList = await ApiOperations.getCategoriesList();
    print("Getting Category Model List");
    print(CatModList);
    setState(() {
      CatModList = CatModList;
    });
  }


GetTrendingWallpapers() async{
  trendingWallList = await ApiOperations.getTrendingWallpapers();

  setState(() {
    isloading = false;
  });
}
  @override
  void initState() {
    super.initState();
    GetCategoryDetails();
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
      body: isloading ? Center(child: SpinKitCircle(color: Colors.amberAccent,),) : SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: searchbar()),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: CatModList.length,
                    itemBuilder: ((context, index) => CatBlock(
                        categoryImgSrcc: CatModList[index].categoryImgUrl,
                        categoryNamee: CatModList[index].categoryName))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 800,
              child: RefreshIndicator(
                onRefresh: () async{
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
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
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>FullScreen(imgPath: trendingWallList[index].imgSrc)));
                        },
                        child: Hero(
                          tag: trendingWallList[index].imgSrc,
                          child: Container(
                            height: 800,
                            width: 50,
                            decoration:
                                BoxDecoration(
                                    color: Colors.black12 ,
                                    borderRadius: BorderRadius.circular(20)),
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
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
