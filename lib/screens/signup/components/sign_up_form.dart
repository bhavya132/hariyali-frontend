import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/signin/sign_in_screen.dart';
import 'package:plant_app/size_config.dart';
import 'package:plant_app/screens/signin/components/form_error.dart';
import 'package:plant_app/screens/signin/components/default_button.dart';
import 'package:plant_app/screens/signin/components/custom_surfix_icon.dart';
import 'package:plant_app/screens/signin/components/keyboard.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:exif/exif.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/brain/UserClass.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  File _image;
  String img64;
  final picker = ImagePicker();
  bool ImageUploaded = false;
  Future pickImage() async {
    final picked_image = await picker.pickImage(source: ImageSource.gallery);
    if (picked_image != null) {
        _image = File(picked_image.path);
        _image = await rotateAndCompressAndSaveImage(_image);
    }
    setState(() {
      if (picked_image != null) {
        _image = File(picked_image.path);
       
        final bytes = File(picked_image.path).readAsBytesSync();
        img64 = base64Encode(bytes);
        // print(img64);
        ImageUploaded = true;
      } else {
        ImageUploaded = false;
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String conformPassword;
  String name;
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
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          nameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          if (ImageUploaded == false)
            GestureDetector(
              onTap: () {
                print("open camera");
                pickImage();
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset("assets/icons/cameraIcon.svg"),
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.05,
                    ),
                    Text(
                      "Upload Photo",
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (ImageUploaded == true) Text("Image is uploaded. "),
          // ImageChangeButton(pickImage()),

          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                 KeyboardUtil.hideKeyboard(context);
                //  UserNotCreatedAlertBox(context);
                int userINfo = await createUserInfo(email, name, img64, conformPassword);
                if (userINfo == 200){
                Navigator.pushNamed(context, SignInScreen.routeName);
                }         
                else {
                  UserNotCreatedAlertBox(context);
                }  
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: kMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
        password = value;
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

  TextFormField nameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User Icon.svg"),
      ),
    );
  }
}


// GestureDetector ImageUploadButton(pickImage) {
  // return 
// }


Future<int> createUserInfo(email, name, img64, conformPassword) async {

  final response = await http.post(
                  Uri.parse('http://192.168.61.217:8000/signup'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, dynamic>{
                    'email': email,
                    'password':conformPassword,
                    'display_picture': img64,
                    'name':name,
                    'plants':[]
                  }),
                );

                return response.statusCode;

                //if (response.statusCode == 200) {
                //   return response.statusCode;
                //   // print(response.statusCode);
                //   // return UserInfo.fromJson(jsonDecode(response.body));

                // }
                // else {
                //   print(response.statusCode);
                //   throw Exception(' Failed to create the user');
                // }
                // else if (response.statusCode == 422) {
                //   String ErrorfromAPi = "Invalid Data";
                //   return ErrorfromAPi;
                // }
}


void UserNotCreatedAlertBox(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return AlertDialog(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 24.0,
        backgroundColor: Colors.red[400],
        title: Text(
          "User Not Created !",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        content:Text("Use Could not be created", 
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


  Future<File> rotateAndCompressAndSaveImage(File image) async {
    int rotate = 0;
    List<int> imageBytes = await image.readAsBytes();
    Map<String, IfdTag> exifData = await readExifFromBytes(imageBytes);

    if (exifData != null &&
        exifData.isNotEmpty &&
        exifData.containsKey("Image Orientation")) {
      IfdTag orientation = exifData["Image Orientation"];
      int orientationValue = orientation.values[0];
      print(orientationValue);
      if (orientationValue == 3) {
        rotate = 180;
      }

      if (orientationValue == 6) {
        rotate = -90;
      }

      if (orientationValue == 8) {
        rotate = 90;
      }
    }

    List<int> result = await FlutterImageCompress.compressWithList(imageBytes,
        quality: 100, rotate: rotate);

    await image.writeAsBytes(result);

    return image;
  }