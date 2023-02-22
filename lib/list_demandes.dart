import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Getdata.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Demandes extends StatefulWidget {
  @override
  State<Demandes> createState() => _DemandesState();
}

dynamic bol;
RefreshController _refreshController1 =
    RefreshController(initialRefresh: false);
RefreshController _refreshController2 =
    RefreshController(initialRefresh: false);

class _DemandesState extends State<Demandes> {
  Future<void> delete_book() async {}

  Future<void> _handleRefresh() async {
    demandes.clear();
    setState(() {
      getdemandess();
    });
    _refreshController1.refreshCompleted();
    _refreshController2.refreshCompleted();
  }

  List demandes = [];
  Future getdemandess() async {
    var url = "https://intertarsal-surface.000webhostapp.com/getBooks.php";
    var res;

    try {
      res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        setState(() {
          var red = json.decode((res.body));
          demandes.addAll(red);
        });
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    demandes.clear();
    super.dispose();
  }

  @override
  void initState() {
    getdemandess();
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
                    "Demandes :",
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
                    child: Column(
                      children: [
                        for (int i = 0; i < demandes.length; i++)
                          ProfileMenu(
                              title: "${demandes[i]["nom_livre"]}",
                              auteur:
                                  "${demandes[i]["nom_auteur"]} ${demandes[i]["prenom_auteur"]}",
                              image:
                                  "https://intertarsal-surface.000webhostapp.com/library1/admin/bookimg/${demandes[i]["image_livre"]}")
                      ],
                    ),
                  ),
                ),
              ),
            ),
      // tionBar: Customnavbar(),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final String title;
  final String auteur;
  final String image;

  const ProfileMenu(
      {Key? key,
      required this.title,
      required this.auteur,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Material(
        color: Color(0xff0F111D),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  backgroundColor: const Color(0xff292B37),
                  title: const Text(
                    'Question',
                    style: TextStyle(
                        fontFamily: "kanit",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.white,
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 21,
                        ),
                        Text(
                          "Annule la demande",
                          style: TextStyle(
                              fontFamily: "kanit",
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: const Text(
                                'Oui',
                                style: TextStyle(
                                    fontFamily: "Kanit",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              onPressed: () {
                                AwesomeDialog(
                                        context: context,
                                        title: "Succès !",
                                        dialogType: DialogType.success,
                                        btnOkOnPress: () {
                                          Navigator.of(context).pop();
                                        },
                                        desc: "Votre demandes a été retiré ")
                                    .show();
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'Non',
                                style: TextStyle(
                                    fontFamily: "Kanit",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
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
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 70,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        height: 90,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$title",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$auteur",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
                bol == null
                    ? Icon(
                        Icons.access_time_filled_rounded,
                        size: 25,
                        color: Colors.white,
                      )
                    : false
                        ? Icon(
                            Icons.check_circle_outline_rounded,
                            size: 25,
                            color: Color.fromARGB(237, 108, 255, 35),
                          )
                        : Icon(
                            Icons.not_interested_rounded,
                            size: 25,
                            color: Color.fromARGB(238, 255, 35, 35),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
