import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/screens/Leaderboard/leadboard.dart';
import 'package:plant_app/screens/garbageTeller/recycle_screen.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/screens/uploadPoints/pointsScreen.dart';

import '../constants.dart';

class MyBottomNavBar extends StatefulWidget {
  final String index;
  const MyBottomNavBar({
    Key key, this.index
  }) : super(key: key);

  

  @override
  _MyBottomNavBar createState() => _MyBottomNavBar();
}

class _MyBottomNavBar extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
 

    Color enableColor = Colors.amber[100];
    Color disableColor = Colors.white; //your color
    print('*********************************');
    print(widget.index);
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 1,
        right: kDefaultPadding * 1,
        bottom: kDefaultPadding,
      ),
      height: 100,
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
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
                // setState(() {
                //   widget.index== 0;
                // });
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    widget.index == '0' ? enableColor : disableColor, // Background Color
              ),
              child: Column(
                children: <Widget>[
                  IconButton(
                      icon: SvgPicture.asset("assets/icons/flower.svg"),
                      color: kPrimaryColor.withOpacity(0.38)),
                  Text("Home")
                ],
              )),
          TextButton(
              onPressed: () 
                  {Navigator.pushNamed(context, PointsScreen.routeName);
                //    setState(() {
                //   index = 1;
                // });
                },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all( widget.index == '1'? enableColor : disableColor)) ,
              child: Column(
                children: <Widget>[
                  IconButton(
                      icon: SvgPicture.asset("assets/icons/sun.svg"),
                      color: kPrimaryColor.withOpacity(0.38)),
                  Text("Earn Points")
                ],
              )),
          TextButton(
              onPressed: () 
                  {Navigator.pushNamed(context, RecycleScreen.routeName);
                //    setState(() {
                //   index = 2;
                // });
                },
              style: TextButton.styleFrom(
                backgroundColor:
                    widget.index == '2' ? enableColor : disableColor, // Background Color
              ),
              child: Column(
                children: <Widget>[
                  IconButton(
                      icon: SvgPicture.asset("assets/icons/heart.svg"),
                      color: kPrimaryColor.withOpacity(0.38)),
                  Text("Recycle")
                ],
              )),
          TextButton(
              onPressed: () 
                  {Navigator.pushNamed(context, LeaderboardScreen.routeName);
                //    setState(() {
                //   index = 3;
                // });
                },
              style: TextButton.styleFrom(
                backgroundColor:
                    widget.index == '3' ? enableColor : disableColor, // Background Color
              ),
              child: Column(
                children: <Widget>[
                  IconButton(
                      icon: SvgPicture.asset("assets/icons/user-icon.svg"),
                      color: kPrimaryColor.withOpacity(0.38)),
                  Text("Leaderboard")
                ],
              )),
        ],
      ),
    );
  }
}
