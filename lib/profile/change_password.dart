import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/main.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Change_password extends StatefulWidget {
  @override
  State<Change_password> createState() => _Change_passwordState();
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

var formKey = GlobalKey<FormState>();

class _Change_passwordState extends State<Change_password> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Text(
                      "Changer mot de passe : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 130,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xffBABCC1)),
                    obscureText: true,
                    controller: myController1,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "*Champ obligatoire !";
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
                      hintText: 'Saisir le mot de passe actuel',
                      labelText: 'Mot de passe actuel',
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
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xffBABCC1)),
                    obscureText: true,
                    controller: myController2,
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
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xffBABCC1)),
                    obscureText: true,
                    controller: myController3,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "*Champ obligatoire !";
                      }
                      if (myController2.text != myController3.text) {
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
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(209, 255, 255, 255),
                          backgroundColor: Color.fromARGB(136, 129, 58, 192),
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (generateMd5(myController1.text) ==
                                prefs.getString("pass")) {
                              try {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    });
                                var url =
                                    'https://intertarsal-surface.000webhostapp.com/changepass.php';
                                var response = await http
                                    .post(Uri.parse(url), body: {
                                  'newpass': generateMd5(myController2.text),
                                  'mail': prefs.getString('email')
                                });
                                if (response.statusCode == 200) {
                                  Navigator.of(context).pop();
                                  AwesomeDialog(
                                          context: context,
                                          title: "Succes !",
                                          dialogType: DialogType.success,
                                          btnOkOnPress: () {},
                                          desc:
                                              "Le Mot de passe est modifié evec succes")
                                      .show();
                                }
                              } catch (e) {}
                              ;
                            } else {
                              AwesomeDialog(
                                      context: context,
                                      title: "Error !",
                                      dialogType: DialogType.error,
                                      btnCancelOnPress: () {},
                                      desc: "Mot de passe actuel eronné")
                                  .show();
                            }
                          }
                        },
                        child: Text(
                          'Changer mot de passe',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "os",
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Color(0xffBABCC1), fontFamily: "os"),
                          )),
                      Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
