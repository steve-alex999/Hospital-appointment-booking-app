import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leso/Screens/administrator/Details/Details_.dart';
import 'package:leso/components/text_field_container.dart';
import '../Date/date.dart';
import '../Login/login_screen.dart';
import '../../constants.dart';
import '../Login/select_type.dart';



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:dartbase_admin/dartbase_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
DocumentReference Drs;


class AppointmentPage extends StatefulWidget {
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<AppointmentPage> {
  //var now = new DateTime.now();
  final List<String> items = ["1", "2", "Third", "4"];

  //final List<String> items=[];

  //MyApp({Key key, @required this.items}) : super(key: key);

  //@override
  Widget build(BuildContext context) {
    final title = 'Upcoming Bookings..';
    var curr_doc;
    add_ () async {

      Drs = await FirebaseFirestore.instance
          .collection('UserDetails').doc(Email_);
      await Drs.get()  .then((DocumentSnapshot documentSnapshot) {
        print('Document data: ${documentSnapshot.data()["name"]}');
        name = documentSnapshot.data()["name"];
        age = documentSnapshot.data()["age"];
        gender = documentSnapshot.data()["gender"];
        number = documentSnapshot.data()["number"];
      });
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Details_()));



    }
    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('current_doc')
                    .snapshots(),
                builder: (BuildContext context1,
                    AsyncSnapshot<QuerySnapshot> snapshot1) {
                  if (!snapshot1.hasData) return Text('Loading...');
                  List<QueryDocumentSnapshot> document11 = snapshot1.data.docs;
                  //final int messageCount = snapshot1.data.docs.length;
                  //curr_doc=document11['curr_doc'];
                  snapshot1.data.docs.forEach((doc) {
                    print("printing.....");
                    print("curr_doc...");
                    curr_doc = doc['curr_doc'];
                    print(curr_doc);
                  });
                  //print(items22);
                  //

                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(Departmant)
                        .doc(curr_doc)
                        .collection('patients')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return Text('Loading...');
                      List<QueryDocumentSnapshot> items22 = snapshot.data.docs;
                       int messageCount = snapshot.data.docs.length;
                      print("=++============");
                      messageCount = messageCount ;
                      print(messageCount);
                      print("curr_doc...");
                      print(curr_doc);

                      return ListView.builder(
                        itemCount: messageCount,
                        itemBuilder: (context, position) {
                          // snapshot.data.documents[index]['name'];
                          // document['userRef'] exists here
                          return TextFieldContainer(child: GestureDetector(


                              child: Text(snapshot.data.docs.elementAt(position).data().containsKey('name') ?
                                  'Patient ID:'+snapshot.data.docs.elementAt(position).data()['name'].toString():
                              snapshot.data.docs.elementAt(position).data().containsKey('index')?'Total Patients:'+snapshot.data.docs.elementAt(position).data()['index'].toString():snapshot.data.docs.elementAt(position).data().containsKey('limit')?'Maximum Patients allowed:'+snapshot.data.docs.elementAt(position).data()['limit'].toString():""
                            ),
                            onTap: () =>
                            {
                              Email_ = snapshot.data.docs.elementAt(position).data()['name'],
                              print(Email_),

                              add_(),



                            },




                          )




                          );


                          // return Card(
                          //
                          //   child: Padding(
                          //
                          //     padding: const EdgeInsets.all(20.0),
                          //     child: Text(snapshot.data.docs.elementAt(position).data()['name'] ??
                          //         '<No message retrieved>'),
                          //
                          //
                          //
                          //
                          //     ),
                          //   );







                        },
                      );
                    },
                  );
                })
        ));
  }
}