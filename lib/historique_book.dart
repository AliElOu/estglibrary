import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Getdata.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'main.dart';

class historique_book extends StatefulWidget {
  @override
  State<historique_book> createState() => _historique_book();
}

RefreshController _refreshController1 =
    RefreshController(initialRefresh: false);
RefreshController _refreshController2 =
    RefreshController(initialRefresh: false);

class _historique_book extends State<historique_book> {
  Future<void> delete_book() async {}

  Future<void> _handleRefresh() async {
    demandes.clear();
    setState(() {
      getdemandes();
    });
    _refreshController1.refreshCompleted();
    _refreshController2.refreshCompleted();
  }

  List demandes = [];
  Future getdemandes() async {
    try {
      var url =
          'https://intertarsal-surface.000webhostapp.com/getHistorique.php';
      var response2 = await http.post(Uri.parse(url), body: {
        'cne': prefs.getString("CNE"),
      });
      if (response2.statusCode == 200) {
        setState(() {
          if (response2.body == "nn") {
            demandes = [1];
            print(demandes[0]);
          } else {
            var red = json.decode((response2.body));
            demandes.addAll(red);
          }
        });
      }
    } catch (e) {
      print("error");
    }
  }

  @override
  void dispose() {
    demandes.clear();
    super.dispose();
  }

  @override
  void initState() {
    getdemandes();
    super.initState();
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
                      demandes.clear();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Historique :",
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
      body: demandes.isEmpty
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
                    child: demandes[0] == 1
                        ? Padding(
                            padding: const EdgeInsets.only(top: 300),
                            child: Center(
                              child: Text(
                                "Pas de réservations !",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(137, 255, 255, 255),
                                    fontFamily: 'os'),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              for (int i = 0; i < demandes.length; i++)
                                SizedBox(
                                  height: 100,
                                  child: Material(
                                    color: Color(0xff0F111D),
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
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
                                                    "https://intertarsal-surface.000webhostapp.com/library1/bookimg/${demandes[i]["image_livre"]}",
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
                                                  "${demandes[i]["nom_livre"]}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Date de Demande : \n${demandes[i]["date_demande"]}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            "${demandes[i]["statue_res"]}" ==
                                                    "1"
                                                ? Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    size: 25,
                                                    color: Color.fromARGB(
                                                        237, 108, 255, 35),
                                                  )
                                                : Icon(
                                                    Icons
                                                        .not_interested_rounded,
                                                    size: 25,
                                                    color: Color.fromARGB(
                                                        238, 255, 35, 35),
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
