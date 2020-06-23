import 'package:flutter/material.dart';

import 'package:healthview/Common/components.dart';
import 'package:healthview/Forms/bloodpressureform.dart';
import 'package:healthview/Forms/measurementform.dart';
import 'package:healthview/Charts/bloodpressurechart.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<String> yearsValues = getYearsList();

  String currentYearsValue = yearsValues.elementAt(14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(),
        // Container for main application
        body: SafeArea(
            child: Column(
          children: <Widget>[
            DropdownButton(
              value: currentYearsValue,
              items: getYearsList()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text('$value'));
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  currentYearsValue = newValue;
                });
              },
            ),
            BloodPressureLineChart(),
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

List<String> getYearsList() {
  int currentYear = new DateTime.now().year;
  List<String> years = new List<String>.generate(
      21, (index) => (currentYear + index - 15).toString());

  years.insert(0, 'All');
  return years;
}
