import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hp_lubricants/screens/PickCar_screen.dart';
import 'package:hp_lubricants/Utilities/VehicleClass.dart';
import 'package:hp_lubricants/Utilities/LubeClass.dart';
import 'package:hp_lubricants/Utilities/VehicleChoiceMaterialButton.dart';
import 'package:hp_lubricants/Utilities/ExpandableList.dart';
import 'package:hp_lubricants/Utilities/CustomButton.dart';
import 'package:hp_lubricants/screens/lubeDisplay_screen.dart';

List<Lube> package = [];

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
  //final Firestore _firestore = Firestore.instance;
  Vehicles vehicles = new Vehicles(
      wheels: "Wheels", fuel: "Fuel", make: "Make", model: "Model");
  Lube lube = new Lube();

  Future signInAnonymous() async {
    AuthResult authResult = await firebaseAuth.signInAnonymously();
    print(authResult.user);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    signInAnonymous();
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'HP Lubricants',
            style: appBarTextStyle,
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
                                List<String> list =
                                    await Vehicles.getMakeList(vehicles);
                                var data = await _awaitSyncData(context, list);
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
                                List<String> list =
                                    await Vehicles.getModelList(vehicles);
                                var data = await _awaitSyncData(context, list);
                                setState(() {
                                  vehicles.model = data;
                                  //getLubeList();
                                });
                              }
                            : null),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: new CustomButton(
                  title: "Get PACKAGE",
                  onpressed: () async {
                    package = await Lube.getPackagesList(vehicles);
                    Navigator.pushNamed(context, LubeDisplayScreen.id,
                        arguments: package);
                    //setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.search),
            backgroundColor: kButtonColor,
            onPressed: () async {
              package = await Lube.getAllLubesList();
              Navigator.pushNamed(context, LubeDisplayScreen.id,
                  arguments: package);
            }));
  }
}
