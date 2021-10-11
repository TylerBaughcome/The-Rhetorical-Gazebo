import "package:flutter/material.dart";
import "RoundedContainer.dart";

class FeaturedNews extends StatelessWidget {
  String? title;
  String? subtitle;
  String? author;
  String description = "Eventual description...";
  //add images later
  FeaturedNews(
      {@required this.title, this.subtitle, @required this.author, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RoundedContainer(
        borderRadius: BorderRadius.circular(4.0),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(this.title!, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
            SizedBox(height: MediaQuery.of(context).size.height/25),
            Row(children: [Text(description)])
          ]
        ) 
      ),
    );
  }
}
