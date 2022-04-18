import 'package:flutter/material.dart';

class UserInfo {
  final String Name;
  final int Score;
  final String email;
  final String DisplayPicture;

  UserInfo({@required this.Name, @required this.Score, @required this.email, @required this.DisplayPicture});
  factory UserInfo.fromJson(Map<String, dynamic> json){
    return UserInfo(
      Name: json['name'],
      Score: json['score'],
      email: json['email'],
      DisplayPicture: json['display_picture'],
    );
  }
}


