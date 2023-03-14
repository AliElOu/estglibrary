import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final PageController _pageController = PageController();
final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Bienvenue dans notre application de bibliothèque !",
    description:
        "Découvrez des dizaines de livres passionnants et trouvez votre prochaine lecture préférée",
    imgUrl: "assets/images/on1.jpg",
  ),
  const OnBoardModel(
    title: "Track your progress with statistics",
    description:
        "Analyse personal result with detailed chart and numerical values",
    imgUrl: 'assets/images/on2.jpg',
  ),
  const OnBoardModel(
    title: "Create photo comparisons and share your results",
    description:
        "Take before and after photos to visualize progress and get the shape that you dream about",
    imgUrl: 'assets/images/on3.jpg',
  ),
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _Onboardingscreenstate createState() => _Onboardingscreenstate();
}

bool isChecked = false;

class _Onboardingscreenstate extends State<OnboardingPage> {
  int currentindex = 0;

  PageController controllerr = PageController();

  @override
  Widget build(BuildContext context) {
    final cw = MediaQuery.of(context).size.width;
    List<Container> cc = [
      Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              height: 400,
              width: cw - 50,
              child: Container(
                child: Image.asset(
                  "assets/images/bg.png",
                ),
              ),
              color: Color.fromARGB(0, 160, 132, 132),
            ),
            SizedBox(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Text(
                      "Bienvenue, ESTG bibliothèque !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffC4C4D6),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Découvrez des dizaines de livres passionnants et trouvez votre prochaine lecture préférée",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 95, 97, 138),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              height: 400,
              width: cw - 50,
              child: Image.asset("assets/images/bg2.png"),
              color: Color.fromARGB(0, 160, 132, 132),
            ),
            SizedBox(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    Text(
                      "Simple et facile à utiliser !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffC4C4D6),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Explorez notre catalogue pour découvrir plusieurs livres de différentes catégories.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 95, 97, 138),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              height: 400,
              width: cw - 50,
              child: Image.asset(
                "assets/images/bg3.png",
              ),
              color: Color.fromARGB(0, 160, 132, 132),
            ),
            SizedBox(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      "Nous sommes ravis de vous aider à cultiver votre amour de la lecture",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffC4C4D6),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Avec notre application, vous pouvez facilement emprunter et lire des livres",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 95, 97, 138),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      Container(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 45,
                    ),
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
                      """- Pour créer un compte veuillez contactez le résponsable de la bibliothèque (Seulement pour les étudiants de l'ESTG).\n
- Vous pouvez réserver moins de trois livres.
- Après avoir réserver un livre, il faut aller le chercher à la bibliothèque.
- Un livre emprunté doit être rendu en moins de sept jours.\n
- La page des demandes présente la liste des livres demandés qui n'ont pas encore reçu de réponse par l’administrateur, et aussi les livres empruntés qui n'ont pas encore été rendus, avec leurs dates de réservation.
- La page d’historique présente tous l’historique des réservations effectuées par un utilisateur sur l'application.\n
-Toute demande non examinée dans les 24 heures par l'administrateur sera supprimée automatiquement.
""",
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
            )
          ],
        ),
      )
    ];
    return Scaffold(
      backgroundColor: Color(0xff2F2E47),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "a",
                      style: TextStyle(color: Color.fromARGB(0, 255, 255, 255)),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (currentindex != cc.length - 1) {
                          controllerr.jumpToPage(4);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 25,
                        width: 50,
                        child: Center(
                          child: currentindex != cc.length - 1
                              ? Text(
                                  "Passer",
                                  style: TextStyle(
                                      color: Color(0xffC4C4D6),
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  "Passer",
                                  style: TextStyle(
                                      color: Color.fromARGB(0, 255, 255, 255),
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: controllerr,
                    itemCount: cc.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentindex = index;
                      });
                    },
                    itemBuilder: (_, i) {
                      return Column(
                        children: [
                          cc[i],
                        ],
                      );
                    }),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 100),
                height: 20,
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: SmoothPageIndicator(
                        effect: SwapEffect(
                          activeDotColor: Color.fromARGB(136, 129, 58, 192),
                          dotColor: Color.fromARGB(255, 104, 104, 117),
                          spacing: 16,
                          dotHeight: 9,
                          dotWidth: 9,
                        ),
                        controller: controllerr,
                        count: 4,
                      ),
                    ),
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
                      if (currentindex == cc.length - 1 && isChecked != false) {
                        Navigator.pushNamed(context, 'loginpage');
                      }
                      if (currentindex != cc.length - 1) {
                        controllerr.nextPage(
                            duration: Duration(milliseconds: 700),
                            curve: Curves.ease);
                      }
                    },
                    child: currentindex != cc.length - 1
                        ? Text(
                            'Suivant',
                            style: TextStyle(
                              fontFamily: "os",
                              fontSize: 16,
                              letterSpacing: 0.2,
                            ),
                          )
                        : Text(
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
