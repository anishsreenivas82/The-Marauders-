import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogindesign/pages/donor_dashboard.dart';
import 'package:flutterlogindesign/pages/qr.dart';
import 'package:fluttertoast/fluttertoast.dart';

String generatedID;
var address, phoneNumber;

class Itempage extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<Itempage> {
  final name = TextEditingController();
  final quantity = TextEditingController();
  final type = TextEditingController();
  final baby = TextEditingController();

  CollectionReference x = FirebaseFirestore.instance.collection('Owners');
  CollectionReference y = FirebaseFirestore.instance.collection('Volunteer');
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Owners')
        .doc(uidDonor)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      address = documentSnapshot.get('Address').toString();
      phoneNumber = documentSnapshot.get('Phone').toString();
    });
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Itempage'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.01, height * 0.01, width * 0.01, height * 0.01),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Product Name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.01, height * 0.01, width * 0.01, height * 0.01),
              child: TextField(
                controller: quantity,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the Quantity'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.01, height * 0.01, width * 0.01, height * 0.01),
              child: TextField(
                controller: baby,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Is it a baby Porduct(yes or no)'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.01, height * 0.01, width * 0.01, height * 0.01),
              child: TextField(
                controller: type,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Type'),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                x.doc(uidDonor).collection('items').add({
                  'Name': name.text,
                  'Type': type.text,
                  'Quantity': quantity.text,
                  'Baby': baby.text
                }).then((querySnapshot) {
                  // Here we call the document just after creation

                  generatedID = querySnapshot.id.toString() +
                      uidDonor
                          .toString(); // Here we call the ID of the document
                  Fluttertoast.showToast(
                      msg: "Item added.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  y
                      .doc('pending verifications')
                      .collection('pending verifications')
                      .add({
                    'Name': name.text,
                    'Address': address,
                    'Phno': phoneNumber,
                  }).then((value) => null);
                });

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Qrcode()));
              },
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}

