import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';

import 'featurred_plants.dart';
import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithCustomUnderline(text: "About the APP"),
          Text(
            "\nHariyali is an application where you can catch unique plants and get the rewards for the same. Currently there are four features of the current version of app:\n\n 1. Click the photo with you and your new plant. \n\n2. Explore about plants nearby you \n\n3. Find whether an item is recyclable or not.\n\n4. Compare yourself in global leaderboard",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kTextColor,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          // TitleWithMoreBtn(title: "Most Searched in your area", press: () {}),
        
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
