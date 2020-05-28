import 'package:flutter/material.dart';

import 'package:healthview/Common/components.dart';
import 'package:healthview/Forms/bloodpressure.dart';
import 'package:healthview/Forms/measurement.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(),
        // Container for main application
        body: SafeArea(
            child: Column(
          children: <Widget>[
            // Button to navigate to blood pressure form for entry
            FlatButton(
              child: Card(
                child: ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Blood Pressure',
                    )),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new BloodPressureForm()));
              },
            ),
            // Button to navigate to Height/Weight form for entry
            FlatButton(
              child: Card(
                child: ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Height/Weight',
                    )),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new MeasurementForm()));
              },
            )
          ],
        )));
  }
}
