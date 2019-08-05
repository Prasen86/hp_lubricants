import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hp_lubricants/screens/PickCar_screen.dart';
import 'package:hp_lubricants/VehicleClass.dart';
import 'package:hp_lubricants/Utilities/LubeClass.dart';
import 'package:hp_lubricants/Utilities/VehicleChoiceMaterialButton.dart';

List<String> carType = ["two-wheeler", "three-wheeler", "four-wheeler"];
List<String> fuelType = ["petrol", "diesel", "CNG"];
List<String> lubes = ["Lal Ghoda", "ATF", "Enklo", "Milcy Turbo"];
List<String> packages = ["1 lt", "500 ml"];
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
  final Firestore _firestore = Firestore.instance;
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

  Future<List<String>> getMakeList() async {
    List<String> list = new List();
    try {
      final messages = await _firestore
          .collection("vehicles")
          .where("type", isEqualTo: vehicles.wheels)
          .getDocuments();
      for (var message in messages.documents) {
        var result = message.data["company"];
        print(result);
        list.add(result);
      }
    } catch (exception) {
      print("Exception : $exception");
      return null;
    }
    return list;
  }

  Future<List<String>> getModelList() async {
    List<String> list = new List();
    try {
      final messages = await _firestore
          .collection("vehicles")
          .where("type", isEqualTo: vehicles.wheels)
          .where("company", isEqualTo: vehicles.make)
          .getDocuments();
      for (var message in messages.documents) {
        var result = message.data["model"];
        print(result);
        list.add(result);
      }
    } catch (exception) {
      print("Exception : $exception");
      return null;
    }
    return list;
  }

  Future<List<String>> getLubeList() async {
    lubes = new List();
    try {
      final messages = await _firestore
          .collection("vehicles")
          .where("type", isEqualTo: vehicles.wheels)
          .where("company", isEqualTo: vehicles.make)
          .where("model", isEqualTo: vehicles.model)
          .getDocuments();
      var result = messages.documents[0].data["lube"];
      setState(() {
        lubes = List.from(result);
      });

      // print(lubes);
    } catch (exception) {
      print("Exception : $exception");
      return null;
    }
    return lubes;
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
                              List<String> list = await getMakeList();
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
                              List<String> list = await getModelList();
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
            RaisedButton(
              child: Text("Get Package"),
              onPressed: () async {
                package = await getPackagesList(vehicles);
                setState(() {});
              },
            ),
            Expanded(
              child: ExpandableList(),
            )
          ],
        ),
      ),
    );
  }
}

Future<List<Lube>> getPackageList() async {
  List<Lube> listLubes = new List<Lube>();

  try {
    for (int i = 0; i < lubes.length; i++) {
      String lubeName = lubes[i];
      List<Package> listPackages = new List<Package>();
      var messages = await Firestore.instance
          .collection("lubes")
          .document(lubeName)
          .collection("package")
          .getDocuments();
      for (var message in messages.documents) {
        Package tempPackage = new Package(
          mrp: message.data["mrp"],
          packageName: message.documentID,
          invoicePrice: message.data["invoice price"],
        );
        listPackages.add(tempPackage);
      }
      Lube tempLube = new Lube(
        name: lubeName,
        packages: listPackages,
      );
      listLubes.add(tempLube);
    }
    print(listLubes[0].name);
  } catch (exception) {
    print("Exception : $exception");
    return null;
  }
  return listLubes;
}

Future<List<Lube>> getPackagesList(Vehicles vehicle) async {
  List<Lube> listLubes = new List<Lube>();

  try {
    List<String> lubeNamesList = new List<String>();
    final messages = await Firestore.instance
        .collection("vehicles")
        .where("type", isEqualTo: vehicle.wheels)
        .where("company", isEqualTo: vehicle.make)
        .where("model", isEqualTo: vehicle.model)
        .getDocuments();
    var result = messages.documents[0].data["lube"];
    lubeNamesList = List.from(result);

    for (int i = 0; i < lubeNamesList.length; i++) {
      String lubeName = lubeNamesList[i];
      List<Package> listPackages = new List<Package>();
      var messages = await Firestore.instance
          .collection("lubes")
          .document(lubeName)
          .collection("package")
          .getDocuments();
      for (var message in messages.documents) {
        Package tempPackage = new Package(
          mrp: message.data["mrp"],
          packageName: message.documentID,
          invoicePrice: message.data["invoice price"],
        );
        listPackages.add(tempPackage);
      }
      Lube tempLube = new Lube(
        name: lubeName,
        packages: listPackages,
      );
      listLubes.add(tempLube);
    }
    print(listLubes[0].name);
  } catch (exception) {
    print("Exception : $exception");
    return null;
  }
  return listLubes;
}

List<Lube> getPackageForEachLube(List<Lube> lubePackages, String lubeNameEach) {
  List<Lube> listOfPacksForEachLube = new List<Lube>();
  print(lubePackages.length);
  for (int i = 0; i < lubePackages.length; i++) {
    if (lubePackages[i].name == lubeNameEach) {
      listOfPacksForEachLube.add(lubePackages[i]);
    }
  }
  print(listOfPacksForEachLube.length);
  return listOfPacksForEachLube;
}

class ExpandableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Lube> packageForEach = [];
    return new ListView.builder(
      itemBuilder: (context, index) => ExpansionTile(
              onExpansionChanged: (b) async {
                //package = await getPackageList();
//                packageForEach = getPackageForEachLube(package, lubes[i]);
//                print(packageForEach.length);
              },
              title: Container(
                child: new Text(package[index].name),
              ),
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: package[index].packages.length,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: EdgeInsets.all(5.0),
                        height: 50.0,
                        child: (Text(
                          (package[index].packages[i].packageName),
                          style: null,
                        )),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                        ),
                      );
                    })
              ]),
      itemCount: package.length,
    );
  }
}
