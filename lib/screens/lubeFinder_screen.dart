import 'package:flutter/material.dart';
import 'package:hp_lubricants/Utilities/BaseAppBar.dart';
import 'package:hp_lubricants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hp_lubricants/screens/PickCar_screen.dart';
import 'package:hp_lubricants/Utilities/VehicleClass.dart';
import 'package:hp_lubricants/Utilities/LubeClass.dart';
import 'package:hp_lubricants/Utilities/VehicleChoiceMaterialButton.dart';
import 'package:hp_lubricants/Utilities/CustomButton.dart';
import 'package:hp_lubricants/screens/lubeDisplay_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  bool showSpinner = false;
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

  void showProgress() {
    setState(() {
      showSpinner = true;
    });
  }

  void noShowProgress() {
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: "Choose your Vehicle",
          leadingImage: 'assets/images/icon_hplubricrant.png',
          appBar: AppBar(),
          //widgets: <Widget>[Icon(Icons.shopping_cart)],
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
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
                            if (data != null) {
                              vehicles.wheels = data;
                              isFuelButtonActive = true;
                            }
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
                                    if (data != null) {
                                      vehicles.fuel = data;
                                      isMakeButtonActive = true;
                                    }
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
                                  showProgress();
                                  List<String> list =
                                      await Vehicles.getMakeList(vehicles);
                                  var data =
                                      await _awaitSyncData(context, list);
                                  setState(() {
                                    showSpinner = false;
                                    if (data != null) {
                                      vehicles.make = data;
                                      isModelButtonActive = true;
                                    }
                                  });
                                }
                              : null),
                      VehicleChoiceMaterialButton(
                          title: vehicles.model,
                          icon: Icons.question_answer,
                          onpressed: isModelButtonActive
                              ? () async {
                                  showProgress();
                                  List<String> list =
                                      await Vehicles.getModelList(vehicles);
                                  var data =
                                      await _awaitSyncData(context, list);
                                  setState(() {
                                    showSpinner = false;
                                    if (data != null) {
                                      vehicles.model = data;
                                    }
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
                    title: "Recommended Lubes",
                    onpressed: () async {
                      showProgress();
                      package = await Lube.getPackagesList(vehicles);
                      if (package != null) {
                        Navigator.pushNamed(context, LubeDisplayScreen.id,
                            arguments: package);
                      }
                      noShowProgress();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.search),
            backgroundColor: kButtonColor,
            onPressed: () async {
              showProgress();
              package = await Lube.getAllLubesList();
              Navigator.pushNamed(context, LubeDisplayScreen.id,
                  arguments: package);
              noShowProgress();
            }));
  }
}
