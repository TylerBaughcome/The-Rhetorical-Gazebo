import "package:flutter/material.dart";
import "RoundedContainer.dart";
import "Article.dart";

class FeaturedNews extends StatelessWidget {
  //TODO: Consider adding description to display with featured news (image too)
  String? title;
  String? subtitle;
  String? author;
  dynamic onTap;
  //add images later
  FeaturedNews(
      {@required this.title, this.subtitle, @required this.author, @required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: RoundedContainer(
          borderRadius: BorderRadius.circular(4.0),
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              this.title!,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(children: [Text(subtitle == null ? "" : subtitle!, style: TextStyle(fontSize: 18))]),
            )
          ]))),
    );
  }
}
