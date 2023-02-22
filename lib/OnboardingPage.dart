import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final PageController _pageController = PageController();
final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Set your own goals and get better",
    description: "Goal support your motivation and inspire you to work harder",
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
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      "Set your on goals and get better",
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
                      "Goal support your motivation and inspire you to work harder",
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
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      "Set your on goals and get better",
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
                      "Goal support your motivation and inspire you to work harder",
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
                      "Set your on goals and get better",
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
                      "Goal support your motivation and inspire you to work harder",
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
    ];

    return Scaffold(
      /* backgroundColor: Colors.white,
      body: OnBoard(
        onBoardData: onBoardData,
        titleStyles: const TextStyle(
          color: Colors.deepOrange,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.15,
        ),
        descriptionStyles: TextStyle(
          fontSize: 16,
          color: Colors.brown.shade300,
        ),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: Colors.deepOrangeAccent,
          activeColor: Colors.deepOrange,
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),
        pageController: _pageController,
        onSkip: () {
          Navigator.pushNamed(context, 'loginpage');
        },
        onDone: () {
          Navigator.pushNamed(context, 'loginpage');
        },
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'loginpage');
              },
              child: Container(
                width: 230,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Colors.redAccent, Colors.deepOrangeAccent],
                  ),
                ),
                child: Text(
                  state.isLastPage ? "Done" : "Next",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }   */

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
                    InkWell(
                      highlightColor: Color.fromARGB(0, 0, 0, 0),
                      onTap: () {
                        Navigator.pushNamed(context, 'loginpage');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 25,
                        width: 50,
                        child: Center(
                          child: Text(
                            "Skip",
                            style: TextStyle(
                                color: Color(0xffC4C4D6),
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
                          spacing: 20,
                          dotHeight: 9,
                          dotWidth: 9,
                        ),
                        controller: controllerr,
                        count: 3,
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
                      if (currentindex == cc.length - 1) {
                        Navigator.pushNamed(context, 'loginpage');
                      }
                      controllerr.nextPage(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.ease);
                    },
                    child: currentindex != cc.length - 1
                        ? Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: "os",
                              fontSize: 16,
                              letterSpacing: 0.2,
                            ),
                          )
                        : Text(
                            'Continue',
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

  void salama() {
    print('salam');
  }
}
