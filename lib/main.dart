import 'package:flutter/material.dart';
// import 'package:myapp/AuthPage.dart';
import 'package:myapp/BookPage.dart';
import 'package:myapp/BookslistPage.dart';
import 'package:myapp/CategoryPage.dart';
import 'package:myapp/profile/Favoris.dart';
import 'package:myapp/Home_Screen.dart';
import 'package:myapp/LoginPage.dart';
import 'package:myapp/OnboardingPage.dart';
import 'package:myapp/profile/change_password.dart';
import 'package:myapp/list_demandes.dart';
import 'package:myapp/new_books.dart';
import 'package:myapp/pop_book.dart';
import 'package:myapp/profile/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
int? isFirstLaunch;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  isFirstLaunch = prefs.getInt('isFirstLaunch');
  await prefs.setInt('isFirstLaunch', 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ESTG-library',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff0F111D),
        primarySwatch: Colors.grey,
      ),
      initialRoute: (isFirstLaunch == 0 || isFirstLaunch == null)
          ? "onboardingpage"
          : prefs.getString("email") == null
              ? "loginpage"
              : "/",
      routes: {
        "loginpage": (context) => const LoginScreen(),
        "/": (context) => const HomePage(),
        "categorypage": (context) => CategoryPage(),
        "bookpage": (context) => BookPage(),
        "onboardingpage": (context) => const OnboardingPage(),
        "bookslistpage": (context) => const BookslistPage(),
        "profilepage": (context) => const ProfilePage(),
        "pop_book": (context) => const Pop_book(),
        "new_book": (context) => const New_books(),
        "demandes": (context) => Demandes(),
        "favoris": (context) => Favoris(),
        "changepass": (context) => Change_password(),
      },
    );
  }
}
