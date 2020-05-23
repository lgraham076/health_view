import 'package:flutter/material.dart';

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
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(child: Text(widget.title)),
        ),
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
                // TODO: Add navigation to BloodPressure form
              },
            ),
            // Button to navigate to Height/Weight form for entryddd
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
                //TODO: Add navigation to Height/Weight form
              },
            )
          ],
        )));
  }
}
