import "package:flutter/material.dart";
import "RoundedContainer.dart";
import "Article.dart";

class FeaturedNews extends StatelessWidget {
  //TODO: Consider adding description to display with featured news (image too)
  String? title;
  String? subtitle;
  String? author;
  String? image_link;
  dynamic onTap;
  //add images later
  FeaturedNews(
      {@required this.title,
      @required this.image_link,
      this.subtitle,
      @required this.author,
      @required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
          onTap: onTap,
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Image.network(image_link!=null ? image_link! : "https://therhetoricalgazebo-media.s3.us-east-2.amazonaws.com/default.jpg"),
                ],
              ),
              // child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              //   Text(
              //     this.title!,
              //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              //   ),
              //   SizedBox(height: MediaQuery.of(context).size.height / 25),
              //   Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 25),
              //     child: Row(children: [Text(subtitle == null ? "" : subtitle!, style: TextStyle(fontSize: 18))]),
              //   )
              // ])
            ),
            Text(
              title!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ])),
    );
  }
}
