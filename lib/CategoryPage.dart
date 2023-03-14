import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Customnavbar.dart';
import 'package:myapp/Getdata.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

RefreshController _refreshController1 =
    RefreshController(initialRefresh: false);
RefreshController _refreshController2 =
    RefreshController(initialRefresh: false);

class _CategoryPageState extends State<CategoryPage> {
  Future<void> _handleRefresh() async {
    ctglist.clear();
    setState(() {
      getCategories();
    });
    _refreshController1.refreshCompleted();
    _refreshController2.refreshCompleted();
  }

  List ctglist = [];
  Future getCategories() async {
    var url = "https://intertarsal-surface.000webhostapp.com/getCategories.php";
    var res;

    try {
      res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        setState(() {
          var red = json.decode((res.body));
          ctglist.addAll(red);
        });
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    ctglist.clear();
    ctgbkslist.clear();
    super.dispose();
  }

  List ctgbkslist = [];


  @override
  void initState() {
    getCategories();
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
                      ctglist.clear();
                      ctgbkslist.clear();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Catégories",
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
      body: ctglist.isEmpty
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
                        for (int i = 0; i < ctglist.length; i++)
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onTap: () async {
                              try {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    });
                                var url =
                                    "https://intertarsal-surface.000webhostapp.com/getCategoriesBooks.php?cat=\"${ctglist[i]["cat_nom"]}\"";
                                var res;
                                try {
                                  res = await http.get(Uri.parse(url));
                                } catch (e) {}

                                if (res.statusCode == 200) {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    var red = json.decode((res.body));
                                    ctgbkslist.addAll(red);
                                  });
                                }
                                Navigator.pushNamed(context, 'bookslistpage',
                                    arguments:
                                        CategotieBookArguments(ctgbkslist));
                              } catch (e) {}
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "https://intertarsal-surface.000webhostapp.com/library1/admin/bookimg/${ctglist[i]["image_cat"]}",
                                      width: 90,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${ctglist[i]["cat_nom"]}",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 23,
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
