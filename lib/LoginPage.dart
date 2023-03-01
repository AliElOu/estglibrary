import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isChecked = false;
var formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  String text1 = "";
  var ex;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  Future<void> wait() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          backgroundColor: Color.fromARGB(255, 129, 58, 192),
          title: const Text(
            'Mot de passe oublié',
            style: TextStyle(
                fontFamily: "kanit",
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          alignment: Alignment.center,
          icon: Icon(
            Icons.email_outlined,
            color: Colors.white,
          ),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                SizedBox(
                  height: 21,
                ),
                Text(
                  'vérifier votre email scolaire',
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

  bool _isSecurepass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2F2E47),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(40),
              child: isloading == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 350),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 130,
                          height: 130,
                        ),
                        SizedBox(
                          height: 39,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 60),
                          child: Text(
                            'Connectez-vous à votre compte',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontFamily: "Kanit",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: myController1,
                          validator: (String? value) {
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (!emailValid) {
                              return "*Email not valid";
                            }
                            if (value!.isEmpty) {
                              return "*Champ obligatoire !";
                            }
                          },
                          style: TextStyle(color: Color(0xffBABCC1)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 28, vertical: 20),
                            labelText: 'Email',
                            hintStyle: TextStyle(
                              color: Color(0xffBABCC1),
                              fontFamily: 'os',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: "Saisir votre Email",
                            labelStyle: TextStyle(
                              color: Color(0xffBABCC1),
                              fontFamily: 'os',
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22),
                              child: Icon(
                                Icons.mail_outline,
                                color: Color(0xffBABCC1),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
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
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: TextStyle(color: Color(0xffBABCC1)),
                          obscureText: true,
                          controller: myController2,
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
                            hintText: 'Saisir votre mot de passe',
                            labelText: 'Mot de passe',
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
                          height: 28,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 140),
                              child: GestureDetector(
                                child: Text(
                                  "Mot de passe oublié ?",
                                  style: TextStyle(
                                    fontFamily: "os",
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffAEAEAE),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: (() {
                                  wait();
                                }),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Color.fromARGB(209, 255, 255, 255),
                            backgroundColor: Color.fromARGB(136, 129, 58, 192),
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 99,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          onPressed: () async {
                            await login(myController1.text, myController2.text);
                          },
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "os",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Text(
                          "IBN ZOHR © 2023",
                          style:
                              TextStyle(color: Color(0xffAEAEAE), fontSize: 12),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  List userdata = [];
  bool isloading = false;
  Future<void> login(String email, String password) async {
    if (formKey.currentState!.validate()) {
      isloading = true;
      setState(() {});
      try {
        var url = 'https://intertarsal-surface.000webhostapp.com/login.php';
        var response = await http.post(Uri.parse(url), body: {
          'email': email,
          'pass': password,
        });
        if (response.statusCode == 200) {
          isloading = false;
          setState(() {});
          if (response.body == 'success') {
            try {
              var url =
                  'https://intertarsal-surface.000webhostapp.com/getuserdata.php';
              var response2 = await http.post(Uri.parse(url), body: {
                'email': email,
              });
              if (response2.statusCode == 200) {
                setState(() {
                  var red = json.decode((response2.body));
                  userdata.addAll(red);
                });
              }
            } catch (e) {}
            prefs.setString("CNE", "${userdata[0]["CNE"]}");
            prefs.setString("nom", "${userdata[0]["nom"]}");
            prefs.setString("prenom", "${userdata[0]["prenom"]}");
            prefs.setString("filiere", "${userdata[0]["nom_fil"]}");
            prefs.setString("email", "${userdata[0]["email"]}");
            prefs.setString("status_cmpt", "${userdata[0]["status_cmpt"]}");
            prefs.setString("pass", "${userdata[0]["pass"]}");

            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          } else {
            AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Invalid email or password !"),
              dialogBackgroundColor: Colors.white,
              dialogType: DialogType.error,
              btnCancelOnPress: () {},
              // btnOkOnPress: () {},
            ).show();
          }
        } else {}
      } catch (e) {}
    }
  }

  Future<void> wait1(String s) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceBetween,
          backgroundColor: Color.fromARGB(255, 129, 58, 192),
          title: Text(
            s,
            style: TextStyle(
                fontFamily: "kanit",
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          alignment: Alignment.center,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 50,
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
}
