import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onpressed;

  CustomButton({this.title, this.onpressed});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: kButtonColor,
      shape: StadiumBorder(
          side: BorderSide(
              color: Colors.white, width: 2.0, style: BorderStyle.solid)),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'LibreBaskerville',
            fontWeight: FontWeight.w900,
            fontSize: 15.0),
      ),
      onPressed: onpressed,
    );
  }
}
