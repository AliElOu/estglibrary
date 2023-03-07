import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Getdata.dart';

class forget_password extends StatefulWidget {
  const forget_password({super.key});

  @override
  State<forget_password> createState() => _forget_passwordState();
}

var formKey = GlobalKey<FormState>();
final myController1 = TextEditingController();

class _forget_passwordState extends State<forget_password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2F2E47),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xff2F2E47),
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
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
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/icons/logo.png",
                  width: 130,
                  height: 130,
                ),
                SizedBox(
                  height: 65,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 62),
                  child: Text(
                    'Vérification d\'adresse Email : ',
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
                    "Veuillez entrer l'adresse email de \n votre compte : ",
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 25,
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 28, vertical: 20),
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
                    if (formKey.currentState!.validate()) {
                      try {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Center(child: CircularProgressIndicator());
                            });
                        var url =
                            'https://intertarsal-surface.000webhostapp.com/forgetpassword/checkemail.php';
                        var response = await http.post(Uri.parse(url),
                            body: {'email': myController1.text});
                        if (response.statusCode == 200) {
                          Navigator.of(context).pop();
                          if (response.body == "Email not found") {
                            AwesomeDialog(
                              context: context,
                              title: "Attention",
                              body: Text("Cet email n'est pas valid !"),
                              dialogBackgroundColor: Colors.white,
                              dialogType: DialogType.warning,
                              btnOkOnPress: () {},
                              btnOkColor: Colors.amber,
                            ).show();
                          } else {
                            Navigator.pushNamed(context, 'verifycode',
                                arguments: emailll("${myController1.text}"));
                          }
                        }
                      } catch (e) {}
                    }
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
                  height: 140,
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
