import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/screens/garbageTeller/components/body.dart';
class RecycleScreen extends StatelessWidget {
  static String routeName = "/recycle";
  const RecycleScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(index:"2"),
    );
  }



  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
     title: Text("HARIYALI"),
    );
  }
}