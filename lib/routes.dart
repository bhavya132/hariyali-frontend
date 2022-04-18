import 'package:flutter/widgets.dart';
import 'package:plant_app/screens/Leaderboard/leadboard.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/screens/details/details_screen.dart';
import 'package:plant_app/screens/uploadPoints/pointsScreen.dart';
import 'package:plant_app/screens/garbageTeller/recycle_screen.dart';
import 'package:plant_app/screens/signin/sign_in_screen.dart';
import 'package:plant_app/screens/signup/sign_up_screen.dart';


final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  PointsScreen.routeName: (context) => PointsScreen(),
  RecycleScreen.routeName: (context) => RecycleScreen(),
  SignInScreen.routeName: (context)=>SignInScreen(),
  SignUpScreen.routeName: (context)=>SignUpScreen(),
  LeaderBoard.routeName: (context) =>LeaderBoard(),


};