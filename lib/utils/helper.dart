import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Helper{
  static Color hexToColor(String code){
    return new Color(int.parse(code.substring(1,7),radix: 16) + 0xFF000000);
  }
  static String millisecondToDate(int timestamp){
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    var now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
  }
}