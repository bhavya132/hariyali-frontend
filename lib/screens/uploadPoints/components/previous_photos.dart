import 'package:flutter/material.dart';
import '../../../constants.dart';

class UploadedPhotos extends StatelessWidget {
  const UploadedPhotos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // UPloadPhotosCard(
            //   image: "assets/images/Pic1_points.jpg",
            //   points: 50,
            //   latitude: 40.6,
            //   longitude: 56.3,
            // ),
            // UPloadPhotosCard(
            //   image: "assets/images/Pic2_points.jpg",
            //   points: 50,
            //   latitude: 44.8,
            //   longitude: 59.1,
            // ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        //   children: <Widget>[
        //     UPloadPhotosCard(
        //       image: "assets/images/image_1.png",
        //       points: 30,
        //       latitude: 40.6,
        //       longitude: 56.3,
        //     ),
        //     UPloadPhotosCard(
        //       image: "assets/images/image_2.png",
        //       points: 30,
        //       latitude: 40.6,
        //       longitude: 56.3,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class UPloadPhotosCard extends StatelessWidget {
  const UPloadPhotosCard({
    Key key,
    this.image,
    this.latitude,
    this.longitude,
    this.points,
  }) : super(key: key);

  final String image;
  final int points;
  final double latitude, longitude;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.35,
      child: Column(
        children: <Widget>[
          Image.asset(image),
          Container(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Lat: $latitude\n",
                        style: TextStyle(
                          color: kTextColor,
                        ),
                      ),
                      TextSpan(
                        text: "Long: $longitude\n",
                        style: TextStyle(
                          color: kTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  '$points\n',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: kPrimaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
