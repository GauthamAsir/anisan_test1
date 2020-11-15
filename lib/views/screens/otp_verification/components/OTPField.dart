import 'dart:async';

import 'package:anisan/constants/MyColors.dart';
import 'package:anisan/constants/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPField extends StatelessWidget {
  const OTPField({
    Key key,
    @required this.errorController,
    @required this.textEditingController,
    @required this.onCompletedOrChange,
  }) : super(key: key);

  final StreamController<ErrorAnimationType> errorController;
  final TextEditingController textEditingController;
  final Function onCompletedOrChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.screenWidth,
      alignment: Alignment.center,
      child: Container(
        width: Sizes.screenWidth * .7,
        child: PinCodeTextField(
          backgroundColor: MyColors.backgroudColor,
          length: 6,
          //textInputType: TextInputType.number,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
          ),
          animationDuration: const Duration(milliseconds: 300),
          errorAnimationController: errorController,
          controller: textEditingController,
          onCompleted: onCompletedOrChange,
          onChanged: onCompletedOrChange,
          appContext: context,
        ),
      ),
    );
  }
}
