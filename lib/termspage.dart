import 'package:flutter/material.dart';

class termspage extends StatefulWidget {
  const termspage({super.key});

  @override
  State<termspage> createState() => _termspageState();
}

bool isChecked = false;

class _termspageState extends State<termspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2F2E47),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 130, 0, 10),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Text(
                          "Termes & conditions",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "Lato"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          """- Pour créer un compte veuillez contactez le résponsable de la bibliothèque (Seulement pour les étudiants de l'ESTG).\n\n- Vous pouvez réserver moins de trois livres.\n- Après avoir réserver un livre, il faut aller le chercher à la bibliothèque.\n- Un livre emprunté doit être rendu en moins de sept jours.\n\n- La page des demandes présente la liste des livres demandés qui n'ont pas encore reçu de réponse par l’administrateur, et aussi les livres empruntés qui n'ont pas encore été rendus, avec leurs dates de réservation.\n- La page d’historique présente tous l’historique des réservations effectuées par un utilisateur sur l'application.\n-Toute demande non examinée dans les 48 heures par l'administrateur sera supprimée automatiquement.""",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(228, 196, 196, 214),
                            fontSize: 14,
                            letterSpacing: 0.15,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "*Veuillez respecter les termes pour éviter les Pénalités",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    letterSpacing: 0.15,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Row(
                    children: [
                      StatefulCheckBox(),
                      Text(
                        "J'ai lu et j'accepte les termes et conditions",
                        style: TextStyle(
                          color: Color.fromARGB(228, 196, 196, 214),
                          fontSize: 12,
                          letterSpacing: 0.15,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(55, 60, 55, 0),
                    height: 130,
                    width: 400,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: Color.fromARGB(136, 129, 58, 192),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        if (isChecked != false) {
                          Navigator.pushNamed(context, 'loginpage');
                        }
                      },
                      child: Text(
                        'Continuer',
                        style: TextStyle(
                          fontFamily: "os",
                          fontSize: 16,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatefulCheckBox extends StatefulWidget {
  const StatefulCheckBox({super.key});

  @override
  State<StatefulCheckBox> createState() => _StatefulCheckBoxState();
}

class _StatefulCheckBoxState extends State<StatefulCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isChecked,
        onChanged: changeCheckboxState,
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Color.fromARGB(135, 255, 255, 255);
          }
          return Color.fromARGB(136, 129, 58, 192);
        }));
  }

  void changeCheckboxState(bool? value) {
    isChecked = value!;
    setState(() {});
  }
}
