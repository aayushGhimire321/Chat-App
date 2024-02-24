import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nepali_chat/screen/chat_page.dart';
import 'package:nepali_chat/screen/login.dart';
import 'package:nepali_chat/screen/register.dart';
import 'package:nepali_chat/screen/splash_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "dev project", options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.route,
      routes: {
        LoginScreen.route: (context) => LoginScreen(),
        RegisterUser.route: (context) => RegisterUser(),
        SplashPage.route: (context) => SplashPage(),
        ChatPage.route: (context) => ChatPage(),
      },
    );
  }
}
