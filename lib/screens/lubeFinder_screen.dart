import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hp_lubricants/screens/PickCar_screen.dart';
import 'package:hp_lubricants/VehicleClass.dart';
import 'package:hp_lubricants/Utilities/VehicleChoiceMaterialButton.dart';

List<String> carType = ["two-wheeler", "three-wheeler", "four-wheeler"];
List<String> fuelType = ["petrol", "diesel", "CNG"];
bool isFuelButtonActive = false,
    isMakeButtonActive = false,
    isModelButtonActive = false;

class LubeFinderScreen extends StatefulWidget {
  static String id = 'lubeFinder_screen';
  @override
  _LubeFinderScreenState createState() => _LubeFinderScreenState();
}

class _LubeFinderScreenState extends State<LubeFinderScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  Vehicles vehicles = new Vehicles(
      wheels: "Wheels", fuel: "Fuel", make: "Make", model: "Model");

  Future signInAnonymous() async {
    AuthResult authResult = await firebaseAuth.signInAnonymously();
    print(authResult.user);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //signInAnonymous();
  }

  Future _awaitSyncData(BuildContext context, List<String> list) async {
    final result = await Navigator.pushNamed(context, PickCar.id,
        //Passing Arguments through Navigator
        arguments: list);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'HP Lubricants',
          style: TextStyle(
              fontFamily: 'LibreBaskerville', fontWeight: FontWeight.bold),
        ),
        leading: Image.asset(
          'assets/images/icon_hplubricrant.png',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
          kbackgroundStartColor,
          kbackgroundEndColor,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  VehicleChoiceMaterialButton(
                    icon: Icons.motorcycle,
                    title: vehicles.wheels,
                    onpressed: () async {
                      var data = await _awaitSyncData(context, carType);
                      setState(() {
                        vehicles.wheels = data;
                        isFuelButtonActive = true;
                      });
                    },
                  ),
                  VehicleChoiceMaterialButton(
                      title: vehicles.fuel,
                      icon: Icons.question_answer,
                      onpressed: isFuelButtonActive
                          ? () async {
                              var data =
                                  await _awaitSyncData(context, fuelType);
                              setState(() {
                                vehicles.fuel = data;
                                isMakeButtonActive = true;
                              });
                            }
                          : null),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  VehicleChoiceMaterialButton(
                      title: vehicles.make,
                      icon: Icons.question_answer,
                      onpressed: isMakeButtonActive
                          ? () async {
                              var data =
                                  await _awaitSyncData(context, fuelType);
                              setState(() {
                                vehicles.make = data;
                                isModelButtonActive = true;
                              });
                            }
                          : null),
                  VehicleChoiceMaterialButton(
                      title: vehicles.model,
                      icon: Icons.question_answer,
                      onpressed: isModelButtonActive
                          ? () async {
                              var data =
                                  await _awaitSyncData(context, fuelType);
                              setState(() {
                                vehicles.model = data;
                              });
                            }
                          : null),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5.0),
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(30.0),
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(30.0),
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
