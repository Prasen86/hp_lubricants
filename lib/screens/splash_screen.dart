import 'package:flutter/material.dart';
import 'lubeFinder_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    //Tweening from 0 to 200 for Scaling UP
    animation = Tween(begin: 0.0, end: 200.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //Move to Lube Finder
        Navigator.pushReplacementNamed(context, LubeFinderScreen.id);
      }
    });

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HP Lubricants',
          style: TextStyle(fontFamily: 'LibreBaskerville'),
        ),
      ),
      body: Center(
        child: Container(
          child: Transform.scale(
            scale: animation.value / 200,
            child: Image.asset(
              'assets/images/background_hplubricants.jpg',
            ),
          ),
        ),
      ),
    );
  }
}
