import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/lubeFinder_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF00264A),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LubeFinderScreen.id: (context) => LubeFinderScreen(),
      },
    );
  }
}