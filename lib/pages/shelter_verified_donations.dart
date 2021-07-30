import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

FirebaseAuth auth = FirebaseAuth.instance;
var uidShelter = auth.currentUser.uid.toString();

class Shelter_verified_don extends StatefulWidget {
  // const Shelter_verified_don({ Key? key }) : super(key: key);

  @override
  _Shelter_verified_donState createState() => _Shelter_verified_donState();
}

class _Shelter_verified_donState extends State<Shelter_verified_don> {
  CollectionReference x = FirebaseFirestore.instance.collection('Shelter');

  final Stream<QuerySnapshot> _Verifieddon = FirebaseFirestore.instance
      .collection('Shelter')
      .doc('donations')
      .collection('donations')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _Verifieddon,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Container(
                  height: height * 0.25,
                  padding: EdgeInsets.fromLTRB(
                      width * 0.01, height * 0.01, width * 0.01, height * 0.01),
                  child: new Card(
                    child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Name-' + data['Name'].toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            'Type-' + data['Type'].toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Quantity-' + data['Quantity'].toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Baby Product-' + data['Baby'].toString(),
                                  style: TextStyle(fontSize: 15),
                                )
                              ]),
                          Text(
                            'Status-' + data['Status'].toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextButton(
                            child: const Text('Proceed'),
                        
                            onPressed: () async {
                      
                              x
                                  .doc(uidShelter)
                                  .collection('previous requests')
                                  .doc(document.id)
                                  .set({
                                'Name': data['Name'].toString(),
                                'Type': data['Type'].toString(),
                                'Quantity': data['Quantity'].toString(),
                                'Baby': data['Baby'].toString()
                              });
                              print(uidShelter.toString());
                              x
                                  .doc('donations')
                                  .collection('donations')
                                  .doc(document.id)
                                  .delete();
                            },
                          ),
                        ],
                      ),
                      // onTap: () => {
                      //   generatedID = document.id.toString() + uidDonor.toString(),
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) => Qrcode()))

                      // },
                    ),
                    // title: new Text(data['Name'].toString()),
                    // subtitle: new Text(data['Type'].toString()),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
