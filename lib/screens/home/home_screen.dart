import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(index:"0"),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
     title: Text("HARIYALI"),
    );
  }
}
