import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

Color getColor({required String colorCode}){
  return Color(int.parse(colorCode)); 
}
String getDate(String? date) {
  if (date != null) {
    return Jiffy.parse(date).fromNow();
  } else {
    return "a few seconds ago";
  }
}