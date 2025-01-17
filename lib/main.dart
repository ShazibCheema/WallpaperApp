import 'package:WallpaperHaven/views/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:WallpaperHaven/views/screens/categori.dart';
import 'package:WallpaperHaven/views/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper Haven',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

