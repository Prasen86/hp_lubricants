import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';

class VehicleChoiceMaterialButton extends StatelessWidget {
  final Function onpressed;
  final String title;
  final IconData icon;

  VehicleChoiceMaterialButton({this.onpressed, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(5.0),
      minWidth: MediaQuery.of(context).size.width / 2.3,
      onPressed: onpressed,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: kbackgroundStartColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      disabledColor: kinactiveColor,
      color: kactiveColor,
      child: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(title),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
