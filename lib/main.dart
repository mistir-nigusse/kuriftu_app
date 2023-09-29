import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:get/get.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/Login_page.dart';
import 'package:kuriftu_app/view/screens/authentication_screen/auth_container_screen.dart';
import 'package:kuriftu_app/view/screens/boarding_screen/boarding_screen.dart';
import 'package:kuriftu_app/view/screens/home_page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final prefs = await SharedPreferences.getInstance();
    final showHome = prefs.getBool('showHome') ?? false;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(MyApp(showHome: showHome));
  } catch (e) {
    // Handle the error appropriately, e.g., log it or show an error message.
    print('Error: $e');
  }
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuriftu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
          backgroundColor: Colors.white,
          splashIconSize: 200,
          splash: Center(
            child: Image.asset('assets/icons/logo.png'),
          ),
          splashTransition: SplashTransition.scaleTransition,
          //  nextScreen: BoardingScreen()),
          nextScreen: showHome ? Login_page() : BoardingScreen()),
    );
  }
}
