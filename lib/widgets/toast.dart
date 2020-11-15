import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastText {
  static toast(String text, {Color bgColor, textColor}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor != null ? bgColor : Colors.blue[800],
        textColor: textColor != null ? textColor : Colors.white,
        fontSize: 16.0,
        webPosition: 'center');
  }
}
