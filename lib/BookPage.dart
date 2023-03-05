import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Customnavbar.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/main.dart';
import 'package:myapp/Getdata.dart';

String a = "", b = "";

class BookPage extends StatefulWidget {
  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    dynamic book = ModalRoute.of(context)!.settings.arguments;
    bool like = book.ck;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Opacity(
              child: Image.network(
                book.image,
                height: 340,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              opacity: 0.4,
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            child: like == false
                                ? Icon(
                                    Icons.favorite_border,
                                    size: 35,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    size: 35,
                                    color: Colors.red,
                                  ),
                            onTap: (() async {
                              if (like == false) {
                                try {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      });
                                  var url =
                                      'https://intertarsal-surface.000webhostapp.com/favoris/insertFav.php';
                                  var response =
                                      await http.post(Uri.parse(url), body: {
                                    'bookisbn': book.isbn,
                                    'userid': prefs.getString("CNE"),
                                  });
                                  if (response.statusCode == 200) {
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                    var red = jsonDecode(response.body);
                                    print(red);
                                  }
                                } catch (e) {}
                              } else {
                                try {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      });
                                  var url =
                                      'https://intertarsal-surface.000webhostapp.com/favoris/deleteFav.php';
                                  var response =
                                      await http.post(Uri.parse(url), body: {
                                    'bookisbn2': book.isbn,
                                    'userid2': prefs.getString("CNE"),
                                  });
                                  if (response.statusCode == 200) {
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                    var red = jsonDecode(response.body);
                                    print(red);
                                  }
                                } catch (e) {}
                              }

                              setState(() {
                                like = !like;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 85,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(192, 129, 58, 192)
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                book.image,
                                height: 250,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                " Catégorie : ${book.categorie}\n\n Auteur : ${book.actor}\n\n Nombre de Pages : ${book.nump}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Description : \n \n${book.description}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Color.fromARGB(192, 129, 58, 192),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onTap: () async {
                                List userdata = [];
                                try {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      });
                                  var url =
                                      'https://intertarsal-surface.000webhostapp.com/getuserdata.php';
                                  var response2 =
                                      await http.post(Uri.parse(url), body: {
                                    'email': prefs.getString("email"),
                                  });
                                  if (response2.statusCode == 200) {
                                    Navigator.of(context).pop();

                                    setState(() {
                                      var red = json.decode((response2.body));
                                      userdata.addAll(red);
                                    });
                                  }
                                } catch (e) {}
                                if (userdata[0]["status_cmpt"] == "1") {
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
                                        'https://intertarsal-surface.000webhostapp.com/reservebook.php';
                                    var response =
                                        await http.post(Uri.parse(url), body: {
                                      'isbn': book.isbn,
                                      'cne': prefs.getString("CNE"),
                                    });
                                    if (response.statusCode == 200) {
                                      Navigator.of(context).pop();
                                      if (response.body == "\ndone") {
                                        AwesomeDialog(
                                          context: context,
                                          title: "Succes",
                                          body: Text(
                                            "Vous avez réserver ce livre avec succes !",
                                            textAlign: TextAlign.center,
                                          ),
                                          dialogBackgroundColor: Colors.white,
                                          dialogType: DialogType.success,
                                          btnOkOnPress: () {},
                                          btnOkColor: Colors.green,
                                        ).show();
                                      } else if (response.body == "\nover") {
                                        AwesomeDialog(
                                          context: context,
                                          title: "Attention",
                                          body: Text(
                                            "Vous n'avez pas le droit de réserver plus de 3 livres !",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: "os"),
                                          ),
                                          dialogBackgroundColor: Colors.white,
                                          dialogType: DialogType.warning,
                                          btnOkOnPress: () {},
                                          btnOkColor: Colors.amber,
                                        ).show();
                                      } else if (response.body == "\nalready") {
                                        AwesomeDialog(
                                          context: context,
                                          title: "Attention",
                                          body: Text(
                                              "Tu as déja reserver ce livre !"),
                                          dialogBackgroundColor: Colors.white,
                                          dialogType: DialogType.warning,
                                          btnOkOnPress: () {},
                                          btnOkColor: Colors.amber,
                                        ).show();
                                      } else if (response.body == "\nfailed") {
                                        AwesomeDialog(
                                          context: context,
                                          title: "Error",
                                          body: Text(
                                              "Ce livre n'est pas en stock pour le moment !"),
                                          dialogBackgroundColor: Colors.white,
                                          dialogType: DialogType.error,
                                          btnCancelOnPress: () {},
                                          // btnOkOnPress: () {},
                                        ).show();
                                      }
                                    }
                                  } catch (e) {}
                                  ;
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    title: "Error",
                                    body: Text(
                                      "Votre compte est suspendu par un administrateur!",
                                      textAlign: TextAlign.center,
                                    ),
                                    dialogBackgroundColor: Colors.white,
                                    dialogType: DialogType.warning,
                                    btnOkOnPress: () {},
                                    btnOkColor: Colors.amber,
                                  ).show();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_outlined,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Réserver",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
class Like extends StatefulWidget {
  const Like({super.key});

  @override
  State<Like> createState() => _LikeState();
}

class _LikeState extends State<Like> {
  @override
  Widget build(BuildContext context) {
    dynamic book = ModalRoute.of(context)!.settings.arguments;
    like = book.ck;

    return GestureDetector(
      child: like == false
          ? Icon(
              Icons.favorite_border,
              size: 35,
              color: Colors.white,
            )
          : Icon(
              Icons.favorite,
              size: 35,
              color: Colors.red,
            ),
      onTap: (() async {
        if (like == false) {
          try {
            var url =
                'https://intertarsal-surface.000webhostapp.com/favoris/insertFav.php';
            var response = await http.post(Uri.parse(url), body: {
              'bookisbn': book.isbn,
              'userid': prefs.getString("CNE"),
            });
            if (response.statusCode == 200) {
              var red = jsonDecode(response.body);
              print(red);
            }
          } catch (e) {}
        } else {
          try {
            var url =
                'https://intertarsal-surface.000webhostapp.com/favoris/deleteFav.php';
            var response = await http.post(Uri.parse(url), body: {
              'bookisbn2': book.isbn,
              'userid2': prefs.getString("CNE"),
            });
            if (response.statusCode == 200) {
              var red = jsonDecode(response.body);
              print(red);
            }
          } catch (e) {}
        }

        setState(() {
          like = !like;
        });
      }),
    );
  }
}
*/