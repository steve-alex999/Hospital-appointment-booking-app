import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Department/layout.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import '../../constants.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../confirm_details/confirm_details.dart';

var enable1=0;
var dateselected = DateTime.now();
var current_doc;
var limitEx = 0;
var msg1 = " ";
var msg2 = " ";
var msg3=" ";
var err = 0;
var curr, limit;
final presum = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  getCurrDoc() async {
    await FirebaseFirestore.instance
        .collection('current_doc')
        .doc('doc_id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print('Document data: ${documentSnapshot.data()["curr_doc"]}');
      current_doc = int.parse(documentSnapshot.data()["curr_doc"]);
    });
    print("%%%%%%%");
    print(current_doc);
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0))),
          title: Text(
            "leso",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          backgroundColor: kPrimaryColor,

        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Align(
              alignment: Alignment.center,
              child:Text(
                "Select Date Of Appointment",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              startDay: DateTime.now(),
              endDay: DateTime.now().add(const Duration(days: 29)),
              onDaySelected: (date, events, _) async {
                enable1=0;
                dateselected = date;
                Date = dateselected.toString();
                await getCurrDoc();
                Duration dur = date.difference(DateTime.now());
                print("sel date: ----------------------");

                print(date);
                print("dur: ----------------------");
                print(dur);
                var d=DateTime.now();
                var curr_day = d.day + presum[d.month - 1];
                var sel_day = date.day + presum[date.month - 1];
                String diff = (sel_day-curr_day).toString();
                print("current_doc:");
                print(current_doc);
                var currInd = (int.parse(diff) + current_doc) % 30;
                if (currInd == 0) {
                  currInd = 30;
                }

                print("current date: ----------------------");
                print(DateTime.now());
                print("difffffffff");
                print(diff);
                print(
                    currInd.toString() + ' is the index of date selected');

                await FirebaseFirestore.instance
                    .collection(Departmant)
                    .doc(currInd.toString())
                    .collection('patients')
                    .doc('limit')
                    .get()
                    .then((DocumentSnapshot documentSnapshot) {
                  print(
                      'limit value : ${documentSnapshot.data()['limit']}');
                  limit = int.parse(documentSnapshot.data()['limit']);
                }).catchError((error) => print("Failed get limit: $error"));

                await FirebaseFirestore.instance
                    .collection(Departmant)
                    .doc(currInd.toString())
                    .collection('patients')
                    .doc('curr_ind')
                    .get()
                    .then((DocumentSnapshot documentSnapshot) {
                  print(
                      'index value : ${documentSnapshot.data()["index"]}');
                  curr = documentSnapshot.data()["index"];
                }).catchError((error) => print("Failed 666666get index: $error"));

                if (curr >= limit) {
                  limitEx = 1;
                  err = 1;
                  msg2 = "No appointments available on this day!!!";
                  msg1=" ";
                  msg3=" ";
                } else {
                  err = 0;
                  limitEx = 0;
                  msg1 = "Appointments are available on this day!!!";
                  msg2=" ";
                  msg3=" ";
                }
                // if (this.mounted) {
                //   setState(() {
                //     print("--------------------------------set state-------------------------------");
                //     //DateTime dob = DateTime.parse('1967-10-12');
                //     dateselected = date;
                //     Date = dateselected.toString();
                //     print("[[[[[[[[");
                //     print(date);
                //     print(Date);
                //   });
                // }
                await FirebaseFirestore.instance
                    .collection(Departmant)
                    .doc((currInd).toString())
                    .collection('patients')
                    .where("name",isEqualTo:FirebaseAuth.instance.currentUser.email)
                    .get()
                    .then((QuerySnapshot documentSnapshot) {
                  print(
                      'index value : ${documentSnapshot.docs.first.data()["name"]}');
                  if(documentSnapshot.docs.isNotEmpty) {
                    enable1 = 0;
                    err=1;
                    msg3="Duplicate Appointment Exists!!";
                    print("Duplicate Appointment Exists");
                  }
                }).catchError((error) => print("Failed get index777777777: $error"));
                if(msg3!=" "){
                  msg2=" ";
                  msg1=" ";
                }
                setState(() {
                  //DateTime dob = DateTime.parse('1967-10-12');
                  print("--------------------------------set state-------------------------------");
                  dateselected = date;
                  Date = dateselected.toString();
                  print("[[[[[[[[");
                  print(date);
                  print(Date);
                  enable1=1;

                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            ..._selectedEvents.map((event) => ListTile(
              title: Text(event),
            )),
            SizedBox(width: 10.0, height: 15.0),
            Align(
              alignment: Alignment.center,
              // Align however you like (i.e .centerRight, centerLeft)

              child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: msg1,
                        style: TextStyle(
                          color: Colors.green,
                        )),
                    TextSpan(
                        text: msg2,
                        style: TextStyle(
                          color: Colors.red,
                        )),
                    TextSpan(
                        text: msg3,
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  ])),
            ),
            SizedBox(width: 10.0, height: 10.0),
            Center(
              child: RoundedButton(
                  text: "Next",
                  color: button,
                  press: () {

                    if (err == 1 || enable1==0) {
                      print("inside else88888888888888888888888888888888888888888888");
                    } else {

                      print("...............");
                      print(Date);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ConfirmPage();
                          },
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    ),
  );

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: _eventController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (_eventController.text.isEmpty) return;
                if (_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay]
                      .add(_eventController.text);
                } else {
                  _events[_controller.selectedDay] = [
                    _eventController.text
                  ];
                }
                prefs.setString("events", json.encode(encodeMap(_events)));
                _eventController.clear();
                Navigator.pop(context);
              },
            )
          ],
        ));
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
    });
  }
}