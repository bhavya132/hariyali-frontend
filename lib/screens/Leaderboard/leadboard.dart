import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/screens/Leaderboard/components/body.dart';
class LeaderboardScreen extends StatelessWidget {
  static String routeName = "/leaderboard";
  const LeaderboardScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: LeaderBoard(),
      bottomNavigationBar: MyBottomNavBar(index:"3"),
    );
  }



  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
     title: Text("HARIYALI"),
    );
  }
}