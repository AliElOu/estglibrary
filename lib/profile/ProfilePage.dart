import 'package:flutter/material.dart';
import 'package:myapp/Customnavbar.dart';
import 'package:myapp/main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String getInitials(String name) => name.isNotEmpty
        ? name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
    return Scaffold(
      backgroundColor: Color(0xff292B37),
      appBar: AppBar(
        toolbarHeight: 100,
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xff0F111D),
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.rowing,
                  color: Colors.transparent,
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0)),
                color: Color(0xff0F111D),
              ),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                        height: 150,
                        width: 150,
                        child: CircleAvatar(
                          backgroundColor: Color(0xff292B37),
                          child: Text(
                            "${getInitials("${prefs.getString("nom")}").toUpperCase()}.${getInitials("${prefs.getString("prenom")}").toUpperCase()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontFamily: 'os',
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80, left: 50),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person_rounded,
                                size: 25,
                                color: Colors.white,
                              ),
                              Text(
                                "   ${prefs.getString("nom")} ${prefs.getString("prenom")} ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.email_rounded,
                                size: 25,
                                color: Colors.white,
                              ),
                              Text(
                                "   ${prefs.getString("email")}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.school_rounded,
                                size: 25,
                                color: Colors.white,
                              ),
                              Text(
                                "   ${prefs.getString("filiere")}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ProfileMenu(
              text: "Changer mot de passe",
              icon: Icons.password_rounded,
              press: (() {
                Navigator.pushNamed(context, 'changepass');
              }),
            ),
            ProfileMenu(
              text: "Favoris",
              icon: Icons.favorite,
              press: (() {
                Navigator.pushNamed(context, 'favoris');
              }),
            ),
            SizedBox(
              height: 80,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                child: Material(
                  color: Color(0xff0F111D),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {
                      prefs.clear();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'loginpage', (route) => false);
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Log Out",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white54,
                                ),
                              ),
                            ])),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //   bottomNavigationBar: Customnavbar(),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Material(
          color: Color(0xff0F111D),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    size: 25,
                    color: Colors.white54,
                  ),
                  Text(
                    "$text",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white54,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 25,
                    color: Colors.white54,
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
