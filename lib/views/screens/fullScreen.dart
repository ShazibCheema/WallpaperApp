import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class FullScreen extends StatefulWidget {
  final String imgPath;

  FullScreen({required this.imgPath});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<FullScreen> {
  var filePath;

  _save() async {
    var response = await Dio().get(widget.imgPath,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgPath,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: kIsWeb
                  ? Image.network(widget.imgPath, fit: BoxFit.cover)
                  : CachedNetworkImage(
                imageUrl: widget.imgPath,
                placeholder: (context, url) => Container(
                  color: Color(0xfff5f8fd),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Downloading Started..."),
                        duration: Duration(seconds: 1),));
                      _save();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Wallpaper Downloaded Successfuly")));
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff1C1B1B).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.white24, width: 1),
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Set Wallpaper",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                       "Image will be saved in gallery",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white70),
                                ),
                              ],
                            )),
                      ],
                    )),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }




}