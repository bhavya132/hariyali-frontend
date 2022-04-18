import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constants.dart';

class TitleAndPrice extends StatelessWidget {
  const TitleAndPrice({
    Key key,
    this.title,
    this.country,
    // this.price,
  }) : super(key: key);

  final String title, country;
  // final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      // child: Row(
      //   children: <Widget>[
      //     RichText(
      //       text: TextSpan(
      //         children: [
      //           TextSpan(
      //             text: "$title\n",
                  
      //             style: Theme.of(context)
      //                 .textTheme
      //                 .headline4
      //                 .copyWith(color: kTextColor, fontWeight: FontWeight.bold),
      //           ),
      //           // TextSpan(
      //           //   text: country,
      //           //   style: TextStyle(
      //           //     fontSize: 20,
      //           //     color: kPrimaryColor,
      //           //     fontWeight: FontWeight.w300,
      //           //   ),
      //           // ),
      //         ],
      //       ),
      //     ),
      //     Spacer(),
      //     Text(
      //       "Origin: $country",
      //       style: Theme.of(context)
      //           .textTheme
      //           .headline5
      //           .copyWith(color: kPrimaryColor),
      //     )
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
         Text(
           "$title\n",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             color: kTextColor,
             fontSize: 38,
             height: 0.7,
           ),
         ),
        //  Text(
        //    "Origin: $country\n",
        //    style:TextStyle(
        //      color: kPrimaryColor,
        //      fontWeight: FontWeight.w400,
        //      fontSize: 30,
        //      height: 0.5,

        //    ),
        //  ),
      ],),
    );
  }
}
