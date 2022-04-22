import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../../../constants.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:plant_app/global.dart';
import 'package:plant_app/brain/UserClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plant_app/screens/signin/sign_in_screen.dart';

class HeadWithButton extends StatefulWidget {
  const HeadWithButton({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _HeadWithButtonState createState() => _HeadWithButtonState();
}

class _HeadWithButtonState extends State<HeadWithButton> {
  UserInfo actualuserinfo = UserInfo(Name: "", Score: 0, email: "", DisplayPicture: "", Plants:[]);
Future<void> GetUserInformation(context) async {
    String accessToken = "";
    if (Access_token == "") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      accessToken = prefs.getString('access') ?? "";
    } else {
      accessToken = Access_token;
    }

    if (accessToken == "") {
      Navigator.pushNamed(context, SignInScreen.routeName);
    } else {
      final response = await http.get(
        Uri.parse('http://192.168.61.217:8000/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
      );
      if (response.statusCode == 200) {
        setState(() {
        actualuserinfo = UserInfo.fromJson(jsonDecode(response.body));
        });
        // return UserInfo.fromJson(jsonDecode(response.body));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('access');
        Navigator.pushNamed(context, SignInScreen.routeName);
      }
    }
  }
    @override
  void initState() {
    GetUserInformation(context);

    super.initState();
  }



  File _image;
  String img64;
  int res;
  final picker = ImagePicker();
  Future pickImage() async {
    final picked_image = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        if (picked_image != null) {
        _image = File(picked_image.path);
        final bytes = File(picked_image.path).readAsBytesSync();
        img64 = base64Encode(bytes);
        // print(img64);
        PostPicForRewards(context, img64).then((res) => {
         if(res==200)
            ScoreAlertBox(context)
         else
          ZeroScoreAlertBox(context)
        });
        PleaseWaitDialogFunction(context);
       
      } else {
        print('No image selected');
      }
      });
      
 
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding ),
      // It will cover 20% of our total height
      height: widget.size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: widget.size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Column(
              children: <Widget>[
                Text(
                "GardenGo",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                 Text(
                "Click photo with you and your plant, and earn points.\nMake sure that your face and the plant could be seen clearly",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.white, ),
                ),
               
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
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
                children: <Widget>[

                     Expanded(
                       child: GestureDetector(
                        onTap: () {
                          pickImage();
                          print("Open Camera");
                        },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset("assets/icons/cameraIcon.svg"),
                              SizedBox(
                                width: widget.size.width * 0.05,
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
                          // margin: EdgeInsets.all(15.0),
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(10.0),
                          //   color: Colors.white,
                          ),
                     ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


void PleaseWaitDialogFunction(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 24.0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "Image Uploaded !",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        content: Text(
          "Your Image will be analyzed and points will be updated soon",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black ),
          ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text(
              "Okay",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}


Future<int> PostPicForRewards(context, img64) async {
  String accessToken = "";
  if (Access_token == "") {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access') ?? "";
  } else {
    accessToken = Access_token;
  }

  if (accessToken == "") {
    Navigator.pushNamed(context, SignInScreen.routeName);
  } else {
    final response = await http.post(
      Uri.parse('http://192.168.61.217:8000/plantation'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{
        'image': img64,
      }),
    );
    print(response.statusCode);
    print(jsonDecode(response.body));
   return response.statusCode;
  }
}


void ScoreAlertBox(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return AlertDialog(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 24.0,
        backgroundColor: Color.fromARGB(255, 127, 230, 108),
        title: Text(
         ' Score updated',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        content:Text("Congratulations!!", 
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


void ZeroScoreAlertBox(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return AlertDialog(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 24.0,
        backgroundColor: Colors.red[400],
        title: Text(
          "Score:0!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        content:Text("Face/Plant not recognised or verified! Please take the photo again", 
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