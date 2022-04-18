import 'package:flutter/material.dart';
import 'package:plant_app/screens/details/components/body.dart';
import 'package:plant_app/brain/SpeciesClass.dart';
class DetailsScreen extends StatelessWidget {
  final SpeciesInfo ActualSpeciesInfo;
  static String routeName = "/details";
  DetailsScreen({@required this.ActualSpeciesInfo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(actualSpeciesInfo: ActualSpeciesInfo),
    );
  }
}
