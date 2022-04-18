import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/routes.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/screens/signin/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant App',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SignInScreen.routeName,
      // initialRoute: HomeScreen.routeName,
      routes: routes,
    );
  }
}
