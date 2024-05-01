import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperapp/views/widgets/CustomAppBar.dart';
import 'package:wallpaperapp/views/widgets/category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    itemCount: 30, itemBuilder: ((context, index) => Category())),
              ),
            ),
            
            SizedBox(
              // height: MediaQuery.of(context).size.height,
              height: 1500,
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 400,
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 10,
              ),
                  itemCount: 16,
                  itemBuilder: (context, index) => Container(
                height: 700,
                width: 50,
                color: Colors.amberAccent,
              )),
            )
          ],
        ),
      ),
    );
  }
}
