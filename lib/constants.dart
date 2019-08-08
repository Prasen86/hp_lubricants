import 'package:flutter/material.dart';

//const Color kactiveColor = Color(0xFF00264A);
//const Color kinactiveColor = Color(0xFF01417d);
const Color kbackgroundEndColor = Color(0xFF0282fa);
const Color kbackgroundStartColor = Color(0xFF000912);
const Color kactiveColor = Colors.white;
const Color kinactiveColor = Colors.white70;
const Color kButtonColor = Color(0xFF000912);
const Color kListColor = Color(0xFF002749);

List<String> carType = ["two-wheeler", "three-wheeler", "four-wheeler"];
List<String> fuelType = ["petrol", "diesel", "CNG"];

const TextStyle appBarTextStyle =
    TextStyle(fontFamily: 'LibreBaskerville', fontWeight: FontWeight.bold);

const TextStyle vehicleChooseTextStyle = TextStyle(
    fontFamily: 'LibreBaskerville',
    fontWeight: FontWeight.w900,
    fontSize: 10.0);

const TextStyle subTitleTextStyle = TextStyle(
    color: Colors.grey,
    fontFamily: 'LibreBaskerville',
    fontStyle: FontStyle.italic);

const TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'LibreBaskerville',
    fontWeight: FontWeight.bold);

const TextStyle packDescTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'LibreBaskerville',
    fontWeight: FontWeight.bold);

const TextStyle packMrpTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'LibreBaskerville',
    decoration: TextDecoration.lineThrough);

const TextStyle packRateTextStyle = TextStyle(
    color: Colors.red,
    fontFamily: 'LibreBaskerville',
    fontWeight: FontWeight.bold);
