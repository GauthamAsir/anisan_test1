import 'dart:async';

import 'package:anisan/constants/MyColors.dart';
import 'package:anisan/constants/sizeConfig.dart';
import 'package:anisan/state/auth/auth.dart';
import 'package:anisan/views/screens/home/home.dart';
import 'package:anisan/views/screens/otp_verification/components/OTPField.dart';
import 'package:anisan/views/screens/splash/SplashScreen.dart';
import 'package:anisan/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'components/SendingOTP.dart';

class OtpVerification extends StatefulWidget {
  final String _phoneNo;
  OtpVerification(this._phoneNo);
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool codeSent = false;
  String verificationId, smsCode = "";

  StreamController<ErrorAnimationType> errorController;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);

    if (!codeSent) {
      verifyPhone("+91 ${widget._phoneNo}");
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (codeSent) ...[
                Text(
                  'Otp Sent to ${widget._phoneNo}',
                  textScaleFactor: 1.3,
                ),
                SizedBox(
                  height: Sizes.defaultSize * 3.5,
                ),
                Container(
                  width: Sizes.screenWidth,
                  child: OTPField(
                    errorController: errorController,
                    textEditingController: textEditingController,
                    onCompletedOrChange: (String v) => smsCode = v,
                  ),
                ),
                SizedBox(
                  height: Sizes.screenHeight * 0.4,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 20),
                  child: FlatButton(
                    onPressed: () async {
                      if (smsCode.length != 6) {
                        errorController.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        return;
                      }

                      try {
                        await Auth.signInWithOTP(smsCode, verificationId);
                        if (Auth.auth.currentUser != null) {
                          ToastText.toast('Logged in');
                          navigate(Home());
                        }
                      } catch (e) {
                        if (Auth.auth.currentUser != null) {
                          ToastText.toast('Error in');
                          navigate(SplashScreen());
                        }
                        var ea = (e as FirebaseAuthException);
                        ToastText.toast(
                          ea.code == "invalid-verification-code"
                              ? "Wrong OTP Try Again."
                              : ea.code == null
                                  ? "Please try after sometime..."
                                  : ea.code,
                        );
                      }
                    },
                    child: Center(
                      child: Text(
                        "verify".trim().toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                )
              ] else ...[
                const SendingOTP(),
                SizedBox(
                  height: Sizes.defaultSize * 8,
                  width: Sizes.screenWidth,
                )
              ],
            ],
          ),
        ),
      ),
    );
  }

  void navigate(dynamic page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }), (route) => false);
  }

  Future<void> verifyPhone(phoneNo) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await Auth.signIn(credential);
        if (Auth.auth.currentUser != null) {
          navigate(Home());
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
        ToastText.toast(e.code);
      },
      codeSent: (String verificationId, int resendToken) {
        // Sign the user in (or link) with the credential
        this.verificationId = verificationId;
        this.codeSent = true;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }
}
