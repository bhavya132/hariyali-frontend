import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:plant_app/screens/signin/sign_in_screen.dart';
import 'dart:convert';

import 'package:plant_app/global.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/brain/UserClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UploadedPhotos extends StatefulWidget {
   const UploadedPhotos({Key key}) : super(key: key);
    @override
  _UploadedPhotosState createState() => _UploadedPhotosState();
}

class _UploadedPhotosState extends State<UploadedPhotos> {
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

  @override
  Widget build(BuildContext context) {
    return UploadedPhotosCard(plants: actualuserinfo.Plants,);
  }
}


class UploadedPhotosCard extends StatelessWidget {
   const UploadedPhotosCard({
    Key key,
    this.plants,
  }) : super(key: key);
  
   final List plants;
  @override
  Widget build(BuildContext context) {
    print(plants);
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.,
      children: <Widget>[
        Wrap(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
             ...plants.map(
            (plant) =>UPloadPhotosCard(
              image: plant['image'],
              points: plant['score'],
              plant_name: plant['name'],
              plant_desc: plant['description'],
            ),
      )
            // UPloadPhotosCard(
            //   image: "assets/images/Pic1_points.jpg",
            //   points: 50,
            //   latitude: 40.6,
            //   longitude: 56.3,
            // ),
            // UPloadPhotosCard(
            //   image: "assets/images/Pic2_points.jpg",
            //   points: 50,
            //   latitude: 44.8,
            //   longitude: 59.1,
            // ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        //   children: <Widget>[
        //     UPloadPhotosCard(
        //       image: "assets/images/image_1.png",
        //       points: 30,
        //       latitude: 40.6,
        //       longitude: 56.3,
        //     ),
        //     UPloadPhotosCard(
        //       image: "assets/images/image_2.png",
        //       points: 30,
        //       latitude: 40.6,
        //       longitude: 56.3,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class UPloadPhotosCard extends StatelessWidget {
  const UPloadPhotosCard({
    Key key,
    this.image,
    this.plant_name,
    this.plant_desc,
    this.points,
  }) : super(key: key);

  final String image;
  final String plant_name;
  final String  plant_desc;
 
  final int points;
  // final double latitude, longitude;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.35,
      child: Column(
        children: <Widget>[
          Image.network(image),
          Container(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: Wrap(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Plant Name: $plant_name\n",
                        style: TextStyle(
                          color: kTextColor,
                        ),
                      ),
                      TextSpan(
                        text: "Plant Description: $plant_desc\n",
                        style: TextStyle(
                          color: kTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  'Score:$points\n',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: kPrimaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
