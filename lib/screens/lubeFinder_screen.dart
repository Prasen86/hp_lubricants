import 'package:flutter/material.dart';
import 'package:hp_lubricants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hp_lubricants/screens/PickCar_screen.dart';
import 'package:hp_lubricants/VehicleClass.dart';
import 'package:hp_lubricants/Utilities/VehicleChoiceMaterialButton.dart';
import 'package:sticky_headers/sticky_headers.dart';

List<String> carType = ["two-wheeler", "three-wheeler", "four-wheeler"];
List<String> fuelType = ["petrol", "diesel", "CNG"];
List<String> lubes = ["Lal Ghoda", "ATF", "Enklo", "Milcy Turbo"];
List<String> packages = ["1 lt", "500 ml"];

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

      print(lubes);
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
                                getLubeList();
                              });
                            }
                          : null),
                ],
              ),
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

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: Colors.blue, width: 2.0, style: BorderStyle.solid),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30.0),
            width: 200.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: Colors.blue, width: 2.0, style: BorderStyle.solid),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30.0),
            width: 200.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: Colors.blue, width: 2.0, style: BorderStyle.solid),
            ),
          ),
        ],
      ),
    );
  }
}

class StickyList extends StatelessWidget {
  final list = new List.generate(10, (i) => "Item ${i + 1}");
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, i) => new StickyHeader(
          header: new Container(
            height: 40.0,
            child: new Text("Header $i"),
            padding: const EdgeInsets.all(8.0),
          ),
          content: new Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Column(
                children: list
                    .map((val) => new ListTile(
                          title: new Text(val),
                        ))
                    .toList()),
          )),
    );
  }
}

class ExpandableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, i) => ExpansionTile(
              title: Container(
                child: new Text(lubes[i]),
              ),
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: packages.length,
                    itemBuilder: (_, i) {
                      return Container(
                        margin: EdgeInsets.all(5.0),
                        height: 50.0,
                        child: (Text(
                          (packages[i]),
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
      itemCount: lubes.length,
    );
  }
}

class LubeList extends StatelessWidget {
  final list = new List.generate(10, (i) => "Item ${i + 1}");
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: 4,
      //shrinkWrap: true,
      itemBuilder: (context, i) => new StickyHeader(
            header: new Container(
              height: 40.0,
              child: new Text("Header $i"),
              padding: const EdgeInsets.all(8.0),
            ),
            content: new Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: new ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      ListTile(
                        title: Text("Hello$index"),
                        //color: Colors.white,
                      );
                    })),
          ),
    );
  }
}
