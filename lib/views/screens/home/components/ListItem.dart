import 'package:anisan/constants/MyColors.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final Function singleTap;

  const ListItem(this.title, this.singleTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListTile(
        onTap: singleTap,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: MyColors.backgroudColor,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
