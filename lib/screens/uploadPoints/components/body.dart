import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';

// import 'featurred_plants.dart';
import 'package:plant_app/screens/uploadPoints/components/head_with_button.dart';
import 'package:plant_app/screens/uploadPoints/components/currentpoints.dart';
import 'package:plant_app/screens/home/components/title_with_more_bbtn.dart';
import 'package:plant_app/screens/uploadPoints/components/previous_photos.dart';

// import 'recomend_plants.dart';
// import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  const Body({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeadWithButton(size: size),
          CurrentPoints(),
          TitleWithMoreBtn(title: "Previous Uploads", press: () {}),
          UploadedPhotos(),



        ],),
    );
  }
}