import 'package:anisan/constants/sizeConfig.dart';
import 'package:flutter/material.dart';

class SendingOTP extends StatelessWidget {
  const SendingOTP({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: Sizes.screenHeight * 0.12,
            ),
            CircularProgressIndicator(
              semanticsLabel: "Sending OTP...",
            ),
            SizedBox(
              height: 20,
            ),
            Text("Sending OTP to your number..."),
          ],
        ),
      ),
    );
  }
}
