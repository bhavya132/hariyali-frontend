import 'dart:convert';
import 'package:plant_app/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/screens/signin/sign_in_screen.dart';
import 'dart:io';
import '../../../constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_app/global.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/brain/UserClass.dart';
import 'package:plant_app/brain/SpeciesClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

// only while developing
// import 'dart:developer';
// import 'package:flutter/foundation.dart';

class HeaderWithSearchBox extends StatefulWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,    
  }) : super(key: key);

  final Size size;

  @override
  _HeaderWithSearchBoxState createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  UserInfo actualuserinfo = UserInfo(Name: "", Score: 0, email: "", DisplayPicture: "");

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

  // String UserName = actualuserinfo.Name;
  File _image;
  String img64;
  final picker = ImagePicker();
  Future getImage() async {
    final picked_image = await picker.getImage(source: ImageSource.camera);

    if (picked_image != null) {
      _image = File(picked_image.path);
      final bytes = File(picked_image.path).readAsBytesSync();
      img64 = base64Encode(bytes);
      GetSpeciesInformation(context, img64);
      // print(img64);
      // log(img64);
      // debugPrint(img64);

      // we make a get request to backend
      // we get some info from backend, and then load new page.
      // Navigator.pushNamed(context, DetailsScreen.routeName);
    } else {
      print('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
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
            child: Row(
              children: <Widget>[
                Text(
                 "Hi "+ actualuserinfo.Name,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundImage: NetworkImage(actualuserinfo.DisplayPicture),
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
                    flex: 5,
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // surffix isn't working properly  with SVG
                        // thats why we use row
                        // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
                  ),
                  SvgPicture.asset("assets/icons/search.svg"),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: SvgPicture.asset("assets/icons/cameraIcon.svg"),
                        tooltip: "search by Pic",
                        onPressed: () {
                          getImage();
                          print("open camera");
                        },
                      ),
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

// to be used when backend is not able to make out wht the pic is about.

void InvalidPicDialogFuntion(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return AlertDialog(
        elevation: 24.0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "Could Not Tell !",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        content: Image.asset(
          "assets/images/recycleGif.gif",
          height: size.height * 0.15,
          width: size.height * 0.15,
        ),
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


Future<void> GetSpeciesInformation(context, img64) async {
  SpeciesInfo actualSpeciesINfo = SpeciesInfo(isPlant: false, plantName: "", wikiurl: "", Description: "" );
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
    print(accessToken);
    final response = await http.post(
      Uri.parse('http://192.168.61.217:8000/species'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{
        'image': img64,
      }),
      
    );

    if (response.statusCode == 200) {
      actualSpeciesINfo = SpeciesInfo.fromJson(jsonDecode(response.body));
      if(actualSpeciesINfo.isPlant == true){
        Navigator.push(context, 

       MaterialPageRoute(builder: (context) => DetailsScreen(ActualSpeciesInfo: actualSpeciesINfo)),
        );
      }
      else {
        InvalidPicDialogFuntion(context);
      }

      
    }
    else {
      InvalidPicDialogFuntion(context);
    }

  }
}