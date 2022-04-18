import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/screens/Leaderboard/leadboard.dart';
import 'package:plant_app/screens/garbageTeller/recycle_screen.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/screens/uploadPoints/pointsScreen.dart';

import '../constants.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/flower.svg"),
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/heart-icon.svg"),
            onPressed: () {
              Navigator.pushNamed(context, PointsScreen.routeName);

            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/user-icon.svg"),
            onPressed: () {
              Navigator.pushNamed(context, RecycleScreen.routeName);

            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/sun.svg"),
            onPressed: () {
              Navigator.pushNamed(context, LeaderBoard.routeName);

            },
          ),
        ],
      ),
    );
  }
}
