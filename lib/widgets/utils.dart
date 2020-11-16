import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
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

  Widget drawerTile1({@required String label, Function onTap, Widget icon}) {
    return Container(
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        onTap: onTap,
        leading: icon,
      ),
    );
  }

  Widget drawerTile2({@required String label, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          label,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
