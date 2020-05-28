import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:healthview/Common/components.dart';

class MeasurementEntry {
  int height;
  int weight;
  DateTime entryDate = DateTime.now();
}

class MeasurementForm extends StatefulWidget {
  @override
  _MeasurementFormState createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<MeasurementForm> {
  final _formKey = GlobalKey<FormState>();

  MeasurementEntry entry = MeasurementEntry();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: <Widget>[
                  Text('Measurements'),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.assignment_ind),
                        labelText: 'Height(inches)'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a height value';
                      }
                      int height = int.tryParse(value);
                      if (height == null) {
                        return 'Please enter a valid integer';
                      } else {
                        entry.height = height;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.assignment_ind),
                        labelText: 'Weight(lbs)'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a weight value';
                      }
                      int weight = int.tryParse(value);
                      if (weight == null) {
                        return 'Please enter a valid integer';
                      } else {
                        entry.weight = weight;
                      }
                      return null;
                    },
                  ),
                  FlatButton(
                      child: ListTile(
                        leading: Icon(Icons.date_range),
                        title: Text(new DateFormat('yyyy-MM-dd HH:mm')
                            .format(entry.entryDate)),
                      ),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: entry.entryDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((date) {
                          setState(() {
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now())
                                .then((time) {
                              if (date != null && time != null) {
                                setState(() {
                                  // Add date to entry
                                  entry.entryDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      time.hour,
                                      time.minute);
                                  print(entry.entryDate);
                                });
                              }
                            });
                          });
                        });
                      }),
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print('Valid form submitted');
                        print(entry);
                      } else {
                        print('Invalid form');
                      }
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
