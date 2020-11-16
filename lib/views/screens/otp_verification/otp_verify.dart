import 'dart:async';

import 'package:anisan/constants/sizeConfig.dart';
import 'package:anisan/state/auth/auth.dart';
import 'package:anisan/views/screens/home/home.dart';
import 'package:anisan/views/screens/otp_verification/components/OTPField.dart';
import 'package:anisan/widgets/button.dart';
import 'package:anisan/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'components/loading.dart';

class OtpVerification extends StatefulWidget {
  final String _phoneNo;
  OtpVerification(this._phoneNo);
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool codeSent = false, loading = false;
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
              Visibility(
                  visible: loading,
                  child: Container(
                    alignment: Alignment.center,
                    height: Sizes.screenHeight,
                    width: Sizes.screenWidth,
                    child: Loading(
                      description: 'Verifying Code',
                    ),
                  )),
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
                Button(
                    buttonText: "verify".trim().toUpperCase(),
                    onPressed: () async {
                      if (smsCode.length != 6) {
                        errorController.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        return;
                      }

                      loading = true;
                      handleState();

                      try {
                        await Auth.signInWithOTP(smsCode, verificationId);
                        if (Auth.auth.currentUser != null) {
                          Utils.toast('Logged in');
                          navigate(Home());
                        }
                      } catch (e) {
                        loading = false;
                        handleState();
                        var ea = (e as FirebaseAuthException);
                        Utils.toast(
                          ea.code == "invalid-verification-code"
                              ? "Wrong OTP Try Again."
                              : ea.code == null
                                  ? "Please try after sometime..."
                                  : ea.code,
                        );
                      }
                    }),
              ] else ...[
                const Loading(
                  text: 'Sending OTP...',
                  description: 'Sending OTP to your number...',
                ),
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
        Utils.toast(e.code);
      },
      codeSent: (String verificationId, int resendToken) {
        // Sign the user in (or link) with the credential
        this.verificationId = verificationId;
        this.codeSent = true;
        handleState();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  handleState() => (mounted) ? setState(() => null) : null;
}
