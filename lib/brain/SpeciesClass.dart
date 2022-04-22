import 'package:flutter/material.dart';

class SpeciesInfo {
  final bool isPlant;
  final String plantName;
   final String plantImg;
  // final List<dynamic> commonNames;
  final String wikiurl;
  final String Description;
   SpeciesInfo({@required this.isPlant, @required this.plantName, @required this.plantImg, @required this.Description,@required this.wikiurl });
   factory SpeciesInfo.fromJson(Map<String, dynamic> json){
     print(json);
     return SpeciesInfo(
       isPlant: json['is_plant'],
       plantName: json['plant_name'],
       plantImg:json['plant_image'],
      //  commonNames: json['common_names'],
       wikiurl: json['url'],
       Description: json['description'],
     );
   }
}