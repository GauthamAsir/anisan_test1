import 'package:anisan/constants/sizeConfig.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String text, description;

  const Loading({Key key, this.text, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: Sizes.screenHeight * 0.12,
          ),
          CircularProgressIndicator(
            semanticsLabel: text == null ? 'Loading...' : text,
          ),
          SizedBox(
            height: 20,
          ),
          Text(description == null ? '' : description),
        ],
      ),
    );
  }
}
