import 'package:flutter/material.dart';
import 'package:grow_more/Admin/home.dart';
import 'package:grow_more/Screens/Welcome/welcome_screen.dart';
import 'package:grow_more/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
      },
    );
  }
}
