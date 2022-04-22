import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/brain/SpeciesClass.dart';
import 'image_and_icons.dart';
import 'title_and_price.dart';

class Body extends StatelessWidget {
  final SpeciesInfo actualSpeciesInfo;
  Body({@required this.actualSpeciesInfo});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(actualSpeciesInfo);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndIcons(size: size, img:actualSpeciesInfo.plantImg),
          TitleAndPrice(title: actualSpeciesInfo.plantName,),
          SizedBox(height: kDefaultPadding),
          // Row(
          //   children: <Widget>[
          //     SizedBox(
          //       width: size.width / 2,
          //       height: 84,
          //       child: FlatButton(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.only(
          //             topRight: Radius.circular(20),
          //           ),
          //         ),
          //         color: kPrimaryColor,
          //         onPressed: () {},
          //         child: Text(
          //           "Buy Now",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 16,
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: FlatButton(
          //         onPressed: () {},
          //         child: Text("Description"),
          //       ),
          //     ),
          //   ],
          // ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Text(
                actualSpeciesInfo.Description,
                style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.w800,),
                textAlign: TextAlign.left,
              ),
            ),),
        ],
      ),
    );
  }
}
