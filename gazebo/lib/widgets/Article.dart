/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';
import "../pages/requests/requests.dart";
import "../pages/Genre.dart";

class Article extends StatelessWidget {
  Map<String, Widget> genre_icons = {
    //Map icons to genres here
  };
  String? title;
  String? subtitle;
  String? genre;
  String? author;
  String? image_link;
  String? article_id;
  bool first_build = true;
  RichText? text = RichText(
      text: TextSpan(children: [
    TextSpan(
        text:
            'This article is missing its appropriate text. Please contact therhetoricalgazebo@gmail.com.',
        style: TextStyle(color: Colors.black)),
  ]));

  //add images later
  Article(
      {required this.title,
      this.subtitle,
      required this.article_id,
      required this.genre,
      required this.author,
      required this.text,
      required this.image_link,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (first_build) {
      add_click(article_id!);
      first_build = false;
    }
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
                      image_link!,
                      //good image: https://static.toiimg.com/photo/msid-58515713,width-96,height-65.cms
                      //ideal resolution/ratio : 3:2 (1000x667)
                      // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      // errorWidget: (context, url, error) => Image.asset('assets/placeholder.jpg',fit: BoxFit.cover,),
                      fit: BoxFit.cover,
                    )),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.03,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GenrePage(genre: genre!)));
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 15),
                        Text(
                          genre!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.slideshow, color: Colors.white, size: 20),
                      ],
                    ),
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
