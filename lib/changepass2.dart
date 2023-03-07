import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Getdata.dart';
import 'dart:convert';

import 'main.dart';

class change_password2 extends StatefulWidget {
  const change_password2({super.key});

  @override
  State<change_password2> createState() => _change_password2State();
}

var formKey = GlobalKey<FormState>();
final myController1 = TextEditingController();
final myController2 = TextEditingController();
List userdata = [];

class _change_password2State extends State<change_password2> {
  @override
  Widget build(BuildContext context) {
    dynamic mmm = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xff2F2E47),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xff2F2E47),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 23,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Mot de passe oublié",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "os"),
                  ),
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 25,
                    color: Color.fromARGB(0, 255, 255, 255),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(children: [
                Image.asset(
                  "assets/icons/logo.png",
                  width: 130,
                  height: 130,
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 62),
                  child: Text(
                    'Modifier votre mot de passe : ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: "Kanit",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 120),
                  child: Text(
                    "Veuillez entrer votre nouveau mot de passe et le confirmer : ",
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  style: TextStyle(color: Color(0xffBABCC1)),
                  obscureText: true,
                  controller: myController1,
                  validator: (String? value) {
                    RegExp regex = RegExp(r'^.{8,}$');

                    if (value!.isEmpty) {
                      return "*Champ obligatoire !";
                    } else {
                      if (!regex.hasMatch(value)) {
                        return "*Le mot de passe doit contenir 8 caractères ou plus !";
                      }
                    }
                  },
                  decoration: InputDecoration(
                    focusColor: Color(0xffBABCC1),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color(0xffBABCC1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color(0xffBABCC1),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 20,
                    ),
                    hintText: 'Saisir le nouveau mot de passe',
                    labelText: 'Nouveau mot de passe',
                    labelStyle: TextStyle(
                      color: Color(0xffBABCC1),
                      fontFamily: 'os',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                    hintStyle: TextStyle(
                      fontFamily: 'os',
                      color: Color(0xffBABCC1),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: Padding(
                      child: Icon(
                        Icons.lock_outline,
                        color: Color(0xffBABCC1),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 22),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  style: TextStyle(color: Color(0xffBABCC1)),
                  obscureText: true,
                  controller: myController2,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "*Champ obligatoire !";
                    }
                    if (myController2.text != myController1.text) {
                      return "*la confirmation du mot de passe est incorrecte !";
                    }
                  },
                  decoration: InputDecoration(
                    focusColor: Color(0xffBABCC1),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color(0xffBABCC1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color(0xffBABCC1),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 20,
                    ),
                    hintText: 'Saisir le nouveau mot de passe',
                    labelText: 'confirmer le nouveau mot de passe',
                    labelStyle: TextStyle(
                      color: Color(0xffBABCC1),
                      fontFamily: 'os',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                    hintStyle: TextStyle(
                      fontFamily: 'os',
                      color: Color(0xffBABCC1),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: Padding(
                      child: Icon(
                        Icons.lock_outline,
                        color: Color(0xffBABCC1),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 22),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(209, 255, 255, 255),
                    backgroundColor: Color.fromARGB(136, 129, 58, 192),
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 80,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  onPressed: () async {
                    userdata.clear();
                    if (formKey.currentState!.validate()) {
                      try {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Center(child: CircularProgressIndicator());
                            });
                        var url =
                            'https://intertarsal-surface.000webhostapp.com/forgetpassword/newpass.php';
                        var response = await http.post(Uri.parse(url), body: {
                          'email': mmm.mail,
                          'pass': myController1.text
                        });
                        if (response.statusCode == 200) {
                          Navigator.of(context).pop();
                          AwesomeDialog(
                            context: context,
                            title: "Attention",
                            body: Text(
                              "Votre mot de passe a été bien modifié !",
                              textAlign: TextAlign.center,
                            ),
                            dialogBackgroundColor: Colors.white,
                            dialogType: DialogType.success,
                            btnOkOnPress: () async {
                              try {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    });
                                var url2 =
                                    'https://intertarsal-surface.000webhostapp.com/getuserdata.php';
                                var response3 =
                                    await http.post(Uri.parse(url2), body: {
                                  'email': mmm.mail,
                                });
                                if (response3.statusCode == 200) {
                                  Navigator.of(context).pop();

                                  setState(() {
                                    var red2 = json.decode((response3.body));
                                    userdata.addAll(red2);
                                  });
                                }
                              } catch (e) {}
                              prefs.setString("CNE", "${userdata[0]["CNE"]}");
                              prefs.setString("nom", "${userdata[0]["nom"]}");
                              prefs.setString(
                                  "prenom", "${userdata[0]["prenom"]}");
                              prefs.setString(
                                  "filiere", "${userdata[0]["nom_fil"]}");
                              prefs.setString(
                                  "email", "${userdata[0]["email"]}");
                              prefs.setString("pass", "${userdata[0]["pass"]}");

                              if (userdata[0]["status_cmpt"] == "0") {
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
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/', (route) => false);
                              }
                            },
                          ).show();
                        }
                      } catch (e) {}
                    }
                  },
                  child: Text(
                    'Valider',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "os",
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                ),
                Text(
                  "IBN ZOHR © 2023",
                  style: TextStyle(color: Color(0xffAEAEAE), fontSize: 12),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
