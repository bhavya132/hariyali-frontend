import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/screens/uploadPoints/components/body.dart';

class PointsScreen extends StatelessWidget {
  static String routeName = "/points";
  const PointsScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(index:"1"),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
     title: Text("HARIYALI"),
    );
  }
}

