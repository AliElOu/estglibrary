import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:myapp/Getdata.dart';

class verifycode extends StatefulWidget {
  const verifycode({super.key});

  @override
  State<verifycode> createState() => _verifycodeState();
}

var formKey = GlobalKey<FormState>();
final myController1 = TextEditingController();

class _verifycodeState extends State<verifycode> {
  @override
  Widget build(BuildContext context) {
    dynamic mm = ModalRoute.of(context)!.settings.arguments;

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
                    "Verification du code",
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
                  height: 55,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 155),
                  child: Text(
                    'Vérifier le code : ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: "Kanit",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 110),
                  child: Text(
                    "Veuillez entrer le code envoyé à : \n alielouankrimi@gmail.com ",
                    style: TextStyle(color: Colors.white54, fontSize: 14.5),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                OtpTextField(
                  fieldWidth: 50.0,
                  borderRadius: BorderRadius.circular(20),
                  numberOfFields: 5,
                  showFieldAsBox: true,
                  focusedBorderColor: Color.fromARGB(150, 129, 58, 192),
                  textStyle: TextStyle(color: Colors.white),
                  onSubmit: (String verificationCode) async {
                    print("$verificationCode || ${mm.mail}");

                    try {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return Center(child: CircularProgressIndicator());
                          });
                      var url =
                          'https://intertarsal-surface.000webhostapp.com/forgetpassword/verifyotp.php';
                      var response = await http.post(Uri.parse(url),
                          body: {'otp': verificationCode, 'email': mm.mail});
                      if (response.statusCode == 200) {
                        Navigator.of(context).pop();
                        if (response.body == "OTP verification success") {
                          Navigator.pushNamed(context, 'changepass2',
                              arguments: emailll(mm.mail));
                        } else {
                          AwesomeDialog(
                            context: context,
                            title: "Attention",
                            body: Text("OTP incorrect"),
                            dialogBackgroundColor: Colors.white,
                            dialogType: DialogType.warning,
                            btnOkOnPress: () {},
                            btnOkColor: Colors.amber,
                          ).show();
                        }
                      }
                    } catch (e) {}
                  },
                  cursorColor: Colors.white,
                ),
                SizedBox(
                  height: 40,
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
