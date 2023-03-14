import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/Customnavbar.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'Getdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePagestate createState() => _HomePagestate();
}

class _HomePagestate extends State<HomePage> {
  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';
  List newbkslist = [];
  List popbkslist = [];

  Future getpopBooks() async {
    var url = "https://intertarsal-surface.000webhostapp.com/getpopBooks.php";
    var res;
    try {
      res = await http.get(Uri.parse(url));

      //Navigator.of(context).pop();

      if (res.statusCode == 200) {
        setState(() {
          var red = json.decode((res.body));
          popbkslist.addAll(red);
        });
      }
    } catch (e) {}
  }

  Future getnewBooks() async {
    var url = "https://intertarsal-surface.000webhostapp.com/getnewBooks.php";
    var res;
    try {
      res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        setState(() {
          var red = json.decode((res.body));
          newbkslist.addAll(red);
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getpopBooks();
    getnewBooks();
    super.initState();
  }

  @override
  void dispose() {
    newbkslist.clear();
    popbkslist.clear();
    super.dispose();
  }

  RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);

  Future<void> _handleRefresh() async {
    popbkslist.clear();
    newbkslist.clear();
    _refreshController1.refreshCompleted();
    setState(() {
      getpopBooks();
      getnewBooks();
    });
  }

  Future<void> error_book(String a) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          backgroundColor: const Color(0xff292B37),
          title: const Text(
            'Error !',
            style: TextStyle(
                fontFamily: "kanit",
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          alignment: Alignment.center,
          icon: Icon(
            Icons.error_outlined,
            color: Colors.white,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 21,
                ),
                Text(
                  a,
                  style: TextStyle(
                      fontFamily: "kanit", color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        fontFamily: "Kanit",
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  TextEditingController _controller = TextEditingController();
  String sel = "all";
  List _books = [];
  dynamic valueitem;
  String? valuesearch;
  String? user;
  List listitem = ["Par Titre", "Par Auteur", "Par ISBN"];

  @override
  Widget malist() {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: DropdownButton(
          underline: SizedBox(),
          icon: const Icon(Icons.filter_list),
          dropdownColor: const Color(0xff292B37),
          focusColor: const Color(0xff292B37),
          iconEnabledColor: Color.fromARGB(255, 205, 208, 225),
          value: valueitem,
          onChanged: (newValue) {
            setState(() {
              valueitem = newValue;
              if (valueitem == "Par Titre") {
                sel = "nom_livre";
              } else if (valueitem == "Par Auteur") {
                sel = "nom_auteur";
              } else if (valueitem == "Par ISBN") {
                sel = "ISBN";
              }
            });
          },
          items: listitem.map((valueitem) {
            /* setState(() {
             
            });*/
            return DropdownMenuItem(
                value: valueitem,
                child: Text(valueitem,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 242, 242, 247),
                        fontSize: 14,
                        fontFamily: 'kanit')));
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: const Color(0xff0F111D),
          automaticallyImplyLeading: false,
          toolbarHeight: 160,
          title: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Salut! ${prefs.getString("prenom")},",
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Que lire ?",
                        style: TextStyle(
                            color: Colors.white54,
                            fontFamily: "os",
                            fontSize: 15),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "profilepage");
                    },
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircleAvatar(
                          backgroundColor: Color(0xff292B37),
                          child: Text(
                            "${getInitials("${prefs.getString("nom")}").toUpperCase()}.${getInitials("${prefs.getString("prenom")}").toUpperCase()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'os',
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xff292B37),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: cw,
                child: TextFormField(
                    style: const TextStyle(
                      fontSize: 16.5,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: malist(),
                      prefixIcon: const Icon(
                        Icons.search_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                      hintText: "Recherche",
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                    onFieldSubmitted: (value) async {
                      dynamic response;
                      try {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Center(child: CircularProgressIndicator());
                            });
                        response = value.isEmpty
                            ? await http.get(Uri.parse(
                                "https://intertarsal-surface.000webhostapp.com/getBooks.php"))
                            : await http.get(Uri.parse(
                                "https://intertarsal-surface.000webhostapp.com/getBooks.php?$sel=\"$value\""));
                      } catch (e) {
                        error_book("Error de connection !");
                      }
                      try {
                        if (response.statusCode == 200) {
                          Navigator.of(context).pop();

                          final data = json.decode(response.body);
                          setState(() {
                            valuesearch = value;
                            _books = data;
                          });
                        }
                      } catch (e) {
                        error_book("pas de livre !");
                      }
                    }),
              ),
            ),
          ])),
      body: _books.isEmpty
          ? SmartRefresher(
              controller: _refreshController1,
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      //Popularwidget(),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Livres populaires",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (() {
                                      Navigator.pushNamed(context, 'pop_book',
                                          arguments: "Livres populaires");
                                    }),
                                    child: Text(
                                      popbkslist.isEmpty ? "" : "Voir tous",
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(height: 15),
                          popbkslist.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 200.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i < popbkslist.length;
                                          i++)
                                        GestureDetector(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                "https://intertarsal-surface.000webhostapp.com/library1/admin/bookimg/${popbkslist[i]["image_livre"]}",
                                                height: 180,
                                                width: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
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
                                                    "${popbkslist[i]["ISBN"]}",
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
                                                    "${popbkslist[i]["ISBN"]}",
                                                    "${popbkslist[i]["nom_livre"]}",
                                                    "https://intertarsal-surface.000webhostapp.com/library1/admin/bookimg/${popbkslist[i]["image_livre"]}",
                                                    "${popbkslist[i]["cat_nom"]}",
                                                    "${popbkslist[i]["nom_auteur"]} ${popbkslist[i]["prenom_auteur"]}",
                                                    int.parse(
                                                        "${popbkslist[i]["num_page"]}"),
                                                    "${popbkslist[i]["description"]}",
                                                    int.parse(
                                                        "${popbkslist[i]["quant"]}"),
                                                    like!));
                                          }),
                                        ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //Newwidget(),
                      newbkslist.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Nouveaux livres",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, 'new_book',
                                              arguments: "Nouveaux livres");
                                        },
                                        child: Text(
                                          "Voir tous",
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  child: Row(
                                    children: [
                                      for (int i = 0;
                                          i < newbkslist.length;
                                          i++)
                                        InkWell(
                                          onTap: () async {
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
                                                    "${newbkslist[i]["ISBN"]}",
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
                                                    "${newbkslist[i]["ISBN"]}",
                                                    "${newbkslist[i]["nom_livre"]}",
                                                    "https://intertarsal-surface.000webhostapp.com/library1/admin/bookimg/${newbkslist[i]["image_livre"]}",
                                                    "${newbkslist[i]["cat_nom"]}",
                                                    "${newbkslist[i]["nom_auteur"]} ${newbkslist[i]["prenom_auteur"]}",
                                                    int.parse(
                                                        "${newbkslist[i]["num_page"]}"),
                                                    "${newbkslist[i]["description"]}",
                                                    int.parse(
                                                        "${newbkslist[i]["quant"]}"),
                                                    like!));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            width: 190,
                                            height: 295,
                                            decoration: BoxDecoration(
                                                color: Color(0xff292B37),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xff292B37)
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 6,
                                                  )
                                                ]),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                  child: Image.network(
                                                    "https://intertarsal-surface.000webhostapp.com/library1/admin/bookimg/${newbkslist[i]["image_livre"]}",
                                                    height: 200,
                                                    width: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${newbkslist[i]["nom_livre"]}",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "${newbkslist[i]["cat_nom"]}",
                                                        style: TextStyle(
                                                          color: Colors.white54,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .chrome_reader_mode,
                                                            color: Colors.amber,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            "${newbkslist[i]["num_page"]}",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .white54,
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
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    for (int index = 0; index < _books.length; index++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 6),
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onTap: () async {
                            bool? like;
                            try {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  });
                              var url =
                                  'https://intertarsal-surface.000webhostapp.com/favoris/checkFav.php';
                              var response =
                                  await http.post(Uri.parse(url), body: {
                                'bookisbn3': "${_books[index]["ISBN"]}",
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
                                    "${_books[index]["ISBN"]}",
                                    "${_books[index]["nom_livre"]}",
                                    "https://intertarsal-surface.000webhostapp.com/library1/admin/bookimg/${_books[index]["image_livre"]}",
                                    "${_books[index]["cat_nom"]}",
                                    "${_books[index]["nom_auteur"]} ${_books[index]["prenom_auteur"]}",
                                    int.parse("${_books[index]["num_page"]}"),
                                    "${_books[index]["description"]}",
                                    int.parse("${_books[index]["quant"]}"),
                                    like!));
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://intertarsal-surface.000webhostapp.com/library1/admin/bookimg/${_books[index]["image_livre"]}",
                                  width: 75,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${_books[index]['nom_livre']}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "${_books[index]['nom_auteur']} ${_books[index]['prenom_auteur']}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("${_books[index]['cat_nom']}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(103, 255, 255, 255),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Customnavbar(),
    );
  }
}

void signout() {}
