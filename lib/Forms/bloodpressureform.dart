import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:healthview/Common/components.dart';
import 'package:healthview/Data/models.dart';



class BloodPressureForm extends StatefulWidget {
  @override
  _BloodPressureFormState createState() => _BloodPressureFormState();
}

class _BloodPressureFormState extends State<BloodPressureForm> {
  final _formKey = GlobalKey<FormState>();
  BloodPressureEntry entry = new BloodPressureEntry();

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
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Blood Pressure'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.assignment_ind),
                        labelText: 'Systolic(mmHg)'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter systolic value';
                      }
                      int systolic = int.tryParse(value);
                      if (systolic == null) {
                        return 'Please enter a valid integer';
                      } else {
                        entry.systolic = systolic;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.assignment_ind),
                        labelText: 'Diastolic(mmHg)'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter diastolic value';
                      }
                      int diastolic = int.tryParse(value);
                      if (diastolic == null) {
                        return 'Please enter a valid integer';
                      } else {
                        entry.diastolic = diastolic;
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
                        ).then((dateInput) {
                          setState(() {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(entry.entryDate))
                                .then((timeInput) {
                              if (dateInput != null && timeInput != null) {
                                setState(() {
                                  // Add date to entry
                                  entry.entryDate = DateTime(
                                      dateInput.year,
                                      dateInput.month,
                                      dateInput.day,
                                      timeInput.hour,
                                      timeInput.minute);
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
                        _save(entry);
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

  void _save(BloodPressureEntry entry) {
    print('BloodPressureForm-Submit: $entry');
    entry.save();
    entry.printAll();
    Navigator.pop(context);
  }
}
