import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/main.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Getdata.dart';

class Favoris extends StatefulWidget {
  @override
  State<Favoris> createState() => _FavorisState();
}

RefreshController _refreshController1 =
    RefreshController(initialRefresh: false);
RefreshController _refreshController2 =
    RefreshController(initialRefresh: false);

class _FavorisState extends State<Favoris> {
  Future<void> delete_book() async {}

  Future<void> _handleRefresh() async {
    favoris.clear();
    setState(() {
      getfavoris();
    });
    _refreshController1.refreshCompleted();
    _refreshController2.refreshCompleted();
  }

  List favoris = [];
  Future getfavoris() async {
    try {
      var url =
          'https://intertarsal-surface.000webhostapp.com/favoris/getFav.php';
      var response2 = await http.post(Uri.parse(url), body: {
        'cne': prefs.getString("CNE"),
      });
      if (response2.statusCode == 200) {
        setState(() {
          if (response2.body == "nn") {
            favoris = [1];
            print(favoris[0]);
          } else {
            var red = json.decode((response2.body));
            favoris.addAll(red);
          }
        });
      }
    } catch (e) {
      print("error");
    }
  }

  @override
  void initState() {
    getfavoris();
    super.initState();
  }

  @override
  void dispose() {
    favoris.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xff0F111D),
        automaticallyImplyLeading: false,
        toolbarHeight: 140,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      favoris.clear();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Favoris :",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: favoris.isEmpty
          ? SmartRefresher(
              controller: _refreshController1,
              onRefresh: _handleRefresh,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 280),
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : SafeArea(
              child: SmartRefresher(
                controller: _refreshController2,
                onRefresh: _handleRefresh,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: favoris[0] == 1
                        ? Padding(
                            padding: const EdgeInsets.only(top: 300),
                            child: Center(
                              child: Text(
                                "Pas de livre !",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(137, 255, 255, 255),
                                    fontFamily: 'os'),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              for (int i = 0; i < favoris.length; i++)
                                SizedBox(
                                  height: 100,
                                  child: Material(
                                    color: Color(0xff0F111D),
                                    borderRadius: BorderRadius.circular(10),
                                    child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                                                "${favoris[i]["ISBN"]}",
                                            'userid3': prefs.getString("CNE"),
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

                                        Navigator.pushNamed(context, 'bookpage',
                                            arguments: BookArguments(
                                                "${favoris[i]["ISBN"]}",
                                                "${favoris[i]["nom_livre"]}",
                                                "https://intertarsal-surface.000webhostapp.com/library1/admin/bookimg/${favoris[i]["image_livre"]}",
                                                "${favoris[i]["cat_nom"]}",
                                                "${favoris[i]["nom_auteur"]} ${favoris[i]["prenom_auteur"]}",
                                                int.parse(
                                                    "${favoris[i]["num_page"]}"),
                                                "${favoris[i]["description"]}",
                                                int.parse(
                                                    "${favoris[i]["quant"]}"),
                                                like!));
                                      }),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 70,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  child: Image.network(
                                                    "https://intertarsal-surface.000webhostapp.com/library1/admin/bookimg/${favoris[i]["image_livre"]}",
                                                    fit: BoxFit.cover,
                                                    height: 90,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${favoris[i]["nom_livre"]}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${favoris[i]["nom_auteur"]} ${favoris[i]["prenom_auteur"]}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog<void>(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      backgroundColor:
                                                          const Color(
                                                              0xff292B37),
                                                      title: const Text(
                                                        'Question',
                                                        style: TextStyle(
                                                            fontFamily: "kanit",
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      icon: Icon(
                                                        Icons
                                                            .delete_forever_rounded,
                                                        color: Colors.white,
                                                      ),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 21,
                                                            ),
                                                            Text(
                                                              "Supprimer de favoris",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "kanit",
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                TextButton(
                                                                  child:
                                                                      const Text(
                                                                    'Oui',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Kanit",
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    try {
                                                                      showDialog(
                                                                          barrierDismissible:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Center(child: CircularProgressIndicator());
                                                                          });
                                                                      var url =
                                                                          'https://intertarsal-surface.000webhostapp.com/favoris/deleteFav.php';
                                                                      var response = await http.post(
                                                                          Uri.parse(
                                                                              url),
                                                                          body: {
                                                                            'bookisbn2':
                                                                                "${favoris[i]["ISBN"]}",
                                                                            'userid2':
                                                                                prefs.getString("CNE"),
                                                                          });
                                                                      if (response
                                                                              .statusCode ==
                                                                          200) {
                                                                        Navigator.of(context)
                                                                            .pop();

                                                                        var red =
                                                                            jsonDecode(response.body);
                                                                        print(
                                                                            red);
                                                                      }
                                                                    } catch (e) {}
                                                                    AwesomeDialog(
                                                                            context:
                                                                                context,
                                                                            title:
                                                                                "Succès !",
                                                                            dialogType: DialogType
                                                                                .success,
                                                                            btnOkOnPress:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            desc:
                                                                                "Ce livre est retiré avec succès")
                                                                        .show();
                                                                    _handleRefresh();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child:
                                                                      const Text(
                                                                    'Non',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Kanit",
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                Icons.favorite_sharp,
                                                size: 25,
                                                color: Color.fromARGB(
                                                    238, 255, 35, 35),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                  ),
                ),
              ),
            ),
    );
  }
}
