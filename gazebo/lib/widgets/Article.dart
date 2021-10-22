/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  Map<String, Widget> genre_icons = {
    //Map icons to genres here
  };
  String? title;
  String? subtitle;
  String? genre;
  String? author;
  RichText? text = RichText(
      text: TextSpan(children: [
    TextSpan(
        text:
            'This article is missing its appropriate text. Please contact therhetoricalgazebo@gmail.com.',
        style: TextStyle(color: Colors.black)),
  ]));

  //add images later
  Article(
      {@required this.title,
      this.subtitle,
      @required this.genre,
      @required this.author,
      @required this.text,
      Key? key})
      : super(key: key);
  static final String path = "lib/src/pages/blog/article1.dart";
  @override
  Widget build(BuildContext context) {
    String image =
        "https://static.toiimg.com/photo/msid-58515713,width-96,height-65.cms";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      image,
                      // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      // errorWidget: (context, url, error) => Image.asset('assets/placeholder.jpg',fit: BoxFit.cover,),
                      fit: BoxFit.cover,
                    )),
                Positioned(
                  bottom: 20.0,
                  left: 20.0,
                  right: 20.0,
                  child: Row(
                    children: <Widget>[
                      //TODO: Associate icon with genre
                      Icon(
                        Icons.slideshow,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        genre!,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Oct 21, 2017"),
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  text!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
