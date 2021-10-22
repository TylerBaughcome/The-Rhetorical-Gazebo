import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:gazebo/pages/Genre.dart';
import "../widgets/RoundedContainer.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "./requests/requests.dart";
import "../widgets/FeaturedNews.dart";
import "../widgets/Article.dart";
import '../functions/parsers.dart';

const Color dotInactive = Color(0x33000000);

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> featured_news_widgets = [];
  Widget popular_column = Column(children: []);
  bool _loading = true;
  Future<void> init() async {
    var digest = await get_home_digest();
    digest["featured"]!.forEach((element) {
      //Convert text to list rich text with text span
      RichText allText = convertText(element["content"]);
      setState(() {
        featured_news_widgets.add(FeaturedNews(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Article(
                        title: element["title"],
                        genre: element["genre"],
                        subtitle: element["subtitle"],
                        author: element["author"],
                        text: allText))),
            title: element["title"],
            subtitle: element["subtitle"],
            author: element["author"]));
      });
    });
    List<Widget> pop_content_util = [];
    print(digest["popular"]);
    digest["popular"]!.forEach((element) {
      pop_content_util.add(_buildListItem(Colors.blue, element));
    });
    setState(() {
      popular_column = Column(children: pop_content_util);
    });
  }

  @override
  void initState() {
    init().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //check if articles loaded

    return _loading
        ? SpinKitWanderingCubes(color: Colors.black)
        : Scaffold(
            drawer: Drawer(
                child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            )),
            bottomNavigationBar: BottomAppBar(
              color: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: ListView(
              children: <Widget>[
                _buildFeaturedNews(),
                const SizedBox(height: 10.0),
                _buildHeading("Popular posts"),
                popular_column,
                _buildHeading("Browse by genre"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            child: Padding(padding: EdgeInsets.fromLTRB(2.0, 0,0,0), child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Creative Writing and Satire", textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(.9))), Icon(Icons.book, color: Colors.white.withOpacity(.9))],),),
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            child: Padding(padding: EdgeInsets.fromLTRB(2.0, 0,0,0), child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Actual News", textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(.9))), Icon(Icons.book, color: Colors.white.withOpacity(.9))],),),
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            child: Padding(padding: EdgeInsets.fromLTRB(2.0, 0,0,0), child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Politics", textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(.9))), Icon(Icons.book, color: Colors.white.withOpacity(.9))],),),
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            child: Padding(padding: EdgeInsets.fromLTRB(2.0, 0,0,0), child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Sports", textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(.9))), Icon(Icons.book, color: Colors.white.withOpacity(.9))],),),
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            child: Padding(padding: EdgeInsets.fromLTRB(2.0, 0,0,0), child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Books and Film", textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(.9))), Icon(Icons.book, color: Colors.white.withOpacity(.9))],),),
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GenrePage(genre: "Opinion"))),
                          child: Container(
                              child: Padding(padding: EdgeInsets.fromLTRB(2.0, 0,0,0), child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Opinion", textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(.9))), Icon(Icons.book, color: Colors.white.withOpacity(.9))],),),
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildListItem(Color color, Map<String, dynamic> content) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 1.5, 0.0, 1.5),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color,
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      content["title"],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                        content["subtitle"] != null ? content["subtitle"]! : "", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildHeading(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.9)),
              ),
            ),
          ),
          MaterialButton(
            elevation: 0,
            textColor: Colors.white,
            color: Colors.black,
            height: 0,
            child: Icon(Icons.keyboard_arrow_right),
            minWidth: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.all(2.0),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  RoundedContainer _buildFeaturedNews() {
    return RoundedContainer(
      height: 270,
      borderRadius: BorderRadius.circular(0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Featured News",
            textAlign: TextAlign.center,
            style: GoogleFonts.newsCycle(
                letterSpacing: 0.75,
                fontSize: 26.0,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 2.5),
          Expanded(
            child: Swiper(
              pagination: const SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: dotInactive,
                    activeColor: Colors.black,
                  ),
                  margin: const EdgeInsets.only()),
              viewportFraction: 0.9,
              autoplay: true,
              itemCount: featured_news_widgets.length,
              loop: true,
              itemBuilder: (context, index) {
                return featured_news_widgets[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
