import 'package:flutter/material.dart';
import 'package:plant_app/screens/signup/components/body.dart';
class SignUpScreen extends StatelessWidget {
  static String routeName = "/signup";

  const SignUpScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Body(),
    );
  }
}