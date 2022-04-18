import 'package:flutter/material.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/size_config.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/signin/components/form_error.dart';
import 'package:plant_app/screens/signin/components/default_button.dart';
import 'package:plant_app/screens/signin/components/custom_surfix_icon.dart';
import 'package:plant_app/screens/signin/components/keyboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plant_app/global.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              // GestureDetector(
              //   onTap: () => Navigator.pushNamed(
              //       context, ForgotPasswordScreen.routeName),
              //   child: Text(
              //     "Forgot Password",
              //     style: TextStyle(decoration: TextDecoration.underline),
              //   ),
              // )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            // press: () {
            //   print("Hello");
            //   Navigator.pushNamed(context, HomeScreen.routeName);
            // },
            press: () async{
              // print("Hello***********");
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // print("Hello");
                KeyboardUtil.hideKeyboard(context);
                int responseCode = await LoginInfo(email, password);
                // print (responseCode);
                // print("*******$responseCode" );
                if (responseCode == 200) {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }
                else {
                  LoginFailureAlertBox(context);
                }

                // if all are valid then go to success screen
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}

Future<int> LoginInfo(email, password) async {
  final response = await http.post(
    Uri.parse('http://192.168.61.217:8000/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  // print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String acessToken = jsonDecode(response.body)['access_token'];
    prefs.setString('access', acessToken);
    Access_token = acessToken;
    print(Access_token);
  }

  return response.statusCode;
  // return 300;

  // if (response.statusCode == 200) {
  //   return response.statusCode;
  //   // print(response.statusCode);
  //   // return UserInfo.fromJson(jsonDecode(response.body));

  // }
  // else {
  //   print(response.statusCode);
  //   throw Exception(' Failed to create the user');
  // }
  // else if (response.statusCode == 422) {
  //   String ErrorfromAPi = "INvalid Data";
  //   return ErrorfromAPi;
  // }
}
void LoginFailureAlertBox(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return AlertDialog(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 24.0,
        backgroundColor: Colors.red[400],
        title: Text(
          "User Not Logged In !",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        content:Text("Use Could not be loggedin ", 
        textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black ),),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text(
              "Okay",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      );
    },
  );
}