import 'package:flutter/material.dart';
import 'package:myapp/Getdata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'main.dart';

class Pop_book extends StatefulWidget {
  const Pop_book({super.key});

  @override
  State<Pop_book> createState() => _Pop_bookState();
}

List popbooks = [];

RefreshController _refreshController1 =
    RefreshController(initialRefresh: false);
RefreshController _refreshController2 =
    RefreshController(initialRefresh: false);

class _Pop_bookState extends State<Pop_book>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Future<void> _handleRefresh() async {
    popbooks.clear();
    setState(() {
      getpopBooks();
    });
    _refreshController1.refreshCompleted();
    _refreshController2.refreshCompleted();
  }

  Future getpopBooks() async {
    var url = "https://intertarsal-surface.000webhostapp.com/getpopBooks.php";
    var res;
    try {
      res = await http.get(Uri.parse(url));

      //Navigator.of(context).pop();

      if (res.statusCode == 200) {
        setState(() {
          var red = json.decode((res.body));
          popbooks.addAll(red);
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getpopBooks();
    super.initState();
  }

  @override
  void dispose() {
    popbooks.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    dynamic st = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 140,
          shadowColor: Colors.transparent,
          backgroundColor: Color(0xff0F111D),
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  popbooks.clear();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "$st",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: Customnavbar(),
        body: popbooks.isEmpty //|| popbooks.isEmpty
            ? SmartRefresher(
                controller: _refreshController1,
                onRefresh: _handleRefresh,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : SafeArea(
                child: SmartRefresher(
                  controller: _refreshController2,
                  onRefresh: _handleRefresh,
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 290,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 6,
                    ),
                    itemCount: popbooks.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: (() async {
                                            bool? like;
                                            try {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  });
                                              var url =
                                                  'https://intertarsal-surface.000webhostapp.com/favoris/checkFav.php';
                                              var response = await http
                                                  .post(Uri.parse(url), body: {
                                                'bookisbn3':
                                                    "${popbooks[index]["ISBN"]}",
                                                'userid3':
                                                    prefs.getString("CNE"),
                                              });

                                              if (response.statusCode == 200) {
                                                Navigator.of(context).pop();
                                                if (response.body == "Y") {
                                                  setState(() {
                                                    like = true;
                                                  });
                                                } else {
                                                  like = false;

                                                  setState(() {});
                                                }
                                              }
                                            } catch (e) {
                                              print("error!");
                                            }

                                            Navigator.pushNamed(
                                                context, 'bookpage',
                                                arguments: BookArguments(
                                                    "${popbooks[index]["ISBN"]}",
                                                    "${popbooks[index]["nom_livre"]}",
                                                    "https://intertarsal-surface.000webhostapp.com/library1/bookimg/${popbooks[index]["image_livre"]}",
                                                    "${popbooks[index]["cat_nom"]}",
                                                    "${popbooks[index]["nom_auteur"]} ${popbooks[index]["prenom_auteur"]}",
                                                    int.parse(
                                                        "${popbooks[index]["num_page"]}"),
                                                    "${popbooks[index]["description"]}",
                                                    int.parse(
                                                        "${popbooks[index]["quant"]}"),
                                                    like!));
                                          }),
                        child: Container(
                          width: 190,
                          height: 295,
                          decoration: BoxDecoration(
                              color: Color(0xff292B37),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff292B37).withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                )
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  "https://intertarsal-surface.000webhostapp.com/library1/bookimg/${popbooks[index]["image_livre"]}",
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${popbooks[index]["nom_livre"]}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "${popbooks[index]["nom_auteur"]} ${popbooks[index]["prenom_auteur"]}",
                                      style: TextStyle(
                                        color: Colors.white54,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.chrome_reader_mode,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${popbooks[index]["num_page"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ));
  }
}
