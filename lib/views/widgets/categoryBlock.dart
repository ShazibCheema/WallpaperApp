import 'package:WallpaperHaven/views/screens/categori.dart';
import 'package:flutter/material.dart';

class CatBlock extends StatelessWidget {
  String categoryNamee;
  String categoryImgSrcc;
  CatBlock({super.key, required this.categoryImgSrcc, required this.categoryNamee});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryScreen(
          CategoryImgUrl: categoryImgSrcc, categoryName: categoryNamee)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 7),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                height: 50, width: 100, fit: BoxFit.cover,categoryImgSrcc,
              ),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Positioned(
              left: 30,
                top: 15,
                child: Text(
                  categoryNamee,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
