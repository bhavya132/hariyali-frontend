import 'package:flutter/material.dart';
import 'package:plant_app/screens/signin/sign_in_screen.dart';
import 'dart:convert';
import '../../../constants.dart';
import 'package:plant_app/global.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/brain/UserClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CurrentPoints extends StatefulWidget {
  const CurrentPoints({
    Key key,
    // @required this.size,
  }) : super(key: key);

  @override
  _CurrentPointsState createState() => _CurrentPointsState();
}

class _CurrentPointsState extends State<CurrentPoints> {
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
  @override
  Widget build(BuildContext context) {
    return CurrentPointsCard(points: actualuserinfo.Score,);
  }
}

class CurrentPointsCard extends StatelessWidget {
  const CurrentPointsCard({
    Key key,
    this.points,
  }) : super(key: key);

  final int points;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        // top: kDefaultPadding / 8,
        bottom: kDefaultPadding / 2,
      ),
      
      width: size.width * 0.8,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[400],
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: kPrimaryColor.withOpacity(0.23),
          ),
        ],
        // border: Border.all(width: 1.0),
        
      ),
      
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: <Widget>[
          Text(
            "Current Points",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: kTextColor,
            ),
            
          ),
          Text(
            "$points",
            style: TextStyle(
              color:kPrimaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 50, ),
          ),
        ],
      ),
    );
  }
}
