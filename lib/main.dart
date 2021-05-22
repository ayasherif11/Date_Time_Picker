import 'package:flutter/material.dart';
import 'NativeSplash.dart';
import 'package:intl/intl.dart';

void main() {
  runApp((NativeSplash()));
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final String formattedate = new DateFormat.yMMMd().format(_currentdate);

    String x =
        "Date is: $formattedate ...Time is: ${selectedTime.format(context)}";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFfdfaf6),
        appBar: AppBar(
          title:
              Text("Date & Time", style: TextStyle(color: Color(0xFFfdfaf6))),
          backgroundColor: Color(0xFF34656d),
        ),
        body: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 200),
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF34656d),
                  child: InkWell(
                      hoverColor: Color(0xFFcbf8ff),
                      splashColor: Color(0xFFcbf8ff),

                      child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          height: 65,
                          child: Text(
                            "PRESS",
                            style: TextStyle(
                                color: Color(0xFFfdfaf6),
                                fontSize: 28,
                                fontWeight: FontWeight.w800),
                          )),
                      onTap: () {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.blueGrey[600].withOpacity(.9),
                                buttonPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                title: Text("Select Date OR Time to set."),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        _selectdate(context);
                                      },
                                      child: Text("Date")),
                                  FlatButton(
                                      onPressed: () {
                                        _selectTime(context);
                                      },
                                      child: Text("Time")),
                                ],
                              );
                            });
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                Card(
                  elevation: 6,
                  child: Text(
                    'Date: $formattedate ',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  shadowColor: Colors.tealAccent[100],
                ),
                Card(
                  elevation: 6,
                  child: Text(
                    'Time: ${selectedTime.format(context)} ',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  shadowColor: Colors.tealAccent[100],
                ),
              ]),
              SizedBox(height: 100),
              Container(
                alignment: Alignment.bottomRight,
                child: Builder(
                    builder: (context) => RaisedButton(
                        color: Color(0xFF34656d).withOpacity(.6),
                        child: Text("Show Selected Date & Time",style: TextStyle(color: Colors.white54),),
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(x,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            duration: const Duration(seconds: 6),
                            backgroundColor: Color(0xFF34656d),
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.only(left: 7),
                          ));
                        })),
              ),
            ]),
      ),
    );
  }

  DateTime _currentdate = new DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<Null> _selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: _currentdate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_seldate != null) {
      setState(() {
        _currentdate = _seldate;
      });
    }
    Navigator.of(context).pop();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
      });
    Navigator.of(context).pop();
  }
}
