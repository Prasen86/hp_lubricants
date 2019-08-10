import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/splash_screen.dart';
import 'screens/lubeFinder_screen.dart';
import 'screens/PickCar_screen.dart';
import 'screens/lubeDisplay_screen.dart';
import 'screens/description_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LubeFinderScreen.id: (context) => LubeFinderScreen(),
        PickCar.id: (context) => PickCar(),
        LubeDisplayScreen.id: (context) => LubeDisplayScreen(),
        DescriptionScreen.id: (context) => DescriptionScreen(),
      },
    );
  }
}
