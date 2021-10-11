import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import "../widgets/RoundedContainer.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "./requests/requests.dart";
import "../widgets/FeaturedNews.dart";

const Color dotInactive = Color(0x33000000);

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> featured_news_widgets = [];
  bool _loading = true;
  Future<void> init() async {
    var digest = await get_home_digest();
    print(digest);
    digest["featured"]!.forEach((element) {
      setState(() {
        featured_news_widgets.add(FeaturedNews(
            title: element["title"],
            subtitle: element["subtitle"],
            author: element["author"]));
      });
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
                _buildListItem(Colors.green.shade200),
                _buildListItem(Colors.red.shade200),
                _buildListItem(Colors.blue.shade200),
                _buildListItem(Colors.red.shade200),
                _buildHeading("Browse by category"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade200,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade200,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade200,
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
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade200,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade200,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade200,
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

  Widget _buildListItem(Color color) {
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
                      "Lorem ipsum dolor sit amet, consecteutur adsd Ut adipisicing dolore incididunt minim",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                        "Mollit aliquip fugiat veniam reprehenderit irure commodo eu aute ex commodo."),
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
