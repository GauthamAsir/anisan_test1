import 'package:anisan/constants/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../otp_verification/otp_verify.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validated = false;
  TextEditingController _controller = new TextEditingController();

  void toast(String text, {Color bgColor, textColor}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor != null ? bgColor : Colors.blue[800],
        textColor: textColor != null ? textColor : Colors.white,
        fontSize: 16.0,
        webPosition: 'center');
  }

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.text.length == 10) {
        _validated = true;
      } else {
        _validated = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 20),
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 5),
                labelText: "mobile_number".trim(),
                helperText: "otp_sent".trim(),
                helperStyle: TextStyle(fontSize: 14),
                errorStyle: TextStyle(fontSize: 14),
                prefixText: "+91 ",
              ),
            ),
            SizedBox(
              height: Sizes.screenHeight * 0.2,
            ),
            FlatButton(
                onPressed: () {
                  if (_validated) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                OtpVerification(_controller.text)));
                  } else {
                    toast('Mobile Number not validated');
                  }
                },
                child: Text(
                  'Send Otp',
                  textScaleFactor: 1.2,
                ))
          ],
        ),
      ),
    );
  }
}
