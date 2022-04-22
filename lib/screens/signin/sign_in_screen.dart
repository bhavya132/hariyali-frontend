import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/signin/components/body.dart';
class SignInScreen extends StatelessWidget {
  static String routeName = "/signin";
  
  const SignInScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}