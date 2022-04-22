import 'package:flutter/material.dart';
import 'package:plant_app/size_config.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/routes.dart';
import 'package:plant_app/screens/signup/sign_up_screen.dart';
import 'package:plant_app/screens/signin/components/sign_form.dart';
class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  "Welcome Back !",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(28),
                  ),
                ),
                Text("Sign in with your email and password", 
                textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SignForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
            "Don’t have an account? ",
            style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                  ),
                  GestureDetector(
            onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
            child: Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  color: kPrimaryColor),
            ),
                  ),
                ],
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
