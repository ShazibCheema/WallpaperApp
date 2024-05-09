import 'package:WallpaperHaven/controller/apioperation.dart';
import 'package:WallpaperHaven/model/photosModel.dart';
import 'package:WallpaperHaven/views/screens/fullScreen.dart';
import 'package:flutter/material.dart';
import 'package:WallpaperHaven/views/widgets/CustomAppBar.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  late List<PhotosModel> searchResults;
  bool isloading = true;
  GetSearchResults() async{

    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {
      isloading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetSearchResults();
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
      body: isloading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SearchBar()),



            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(

                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 400,
                    crossAxisCount: 2,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 10,
                  ),

                  itemCount: searchResults.length,
                  itemBuilder: (context, index) => GridTile(
                    child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FullScreen(
                                            imgPath: searchResults[index]
                                                .imgSrc)));
                          },
                      child: Hero(
                        tag: searchResults[index].imgSrc,
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
                                searchResults[index].imgSrc),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
