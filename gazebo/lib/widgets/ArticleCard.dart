import "package:flutter/material.dart";
import 'package:gazebo/functions/parsers.dart';
import "Article.dart";
class ArticleCard extends StatelessWidget {
  Map<String, dynamic>? article_content;
  ArticleCard({@required this.article_content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9 * MediaQuery.of(context).size.width / 10,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => Article(
                      article_id: article_content!["_id"],
                      title: article_content!["title"],
                      genre: article_content!["genre"],
                      subtitle: article_content!["subtitle"],
                      author: article_content!["author"],
                      image_link: article_content!["image_link"],
                      text: convertText(article_content!["content"]))));
            },
            child: Image.network(
                //TODO: Find best dimensions/resolution for genre list images
                //BEST: 400x225 -> Scale/accept images with this ratio (larger the original resolution the better)
                //article_content!["image_link"] != null ? article_content!["image_link"] : "https://lh3.googleusercontent.com/proxy/c_7OOLgBbazmqUc8-otxDr6FfVoUFd62zzpdFYQ0fFwUKuygQVB3vdwOXCEoFEuDxpgOn9sOlgeAtQGJEXyk36Rdv3FHMxN3pPjfcv9v2Tco_7R_uUs0CV-ps4zc1TEC84mBOxH9SDBjFuqrpmU8WEPCEC_4yWlf03wuxA",
                article_content!["image_link"] != null
                    ? article_content!["image_link"]
                    : "https://therhetoricalgazebo-media.s3.us-east-2.amazonaws.com/default.jpg"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Title(
              color: Colors.black,
              child: Text(article_content!["title"],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 18))),
        ),
        Text(article_content!["subtitle"],
            style: TextStyle(color: Colors.grey)),
        Divider(color: Colors.grey)
      ]),
    );
  }
}
