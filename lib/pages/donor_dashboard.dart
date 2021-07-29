import 'package:flutter/material.dart';
import 'package:flutterlogindesign/pages/signin_page.dart';
import 'package:flutterlogindesign/pages/item_page.dart';
import 'package:flutterlogindesign/pages/signup_page.dart';
import 'package:flutterlogindesign/pages/previous_orders.dart';

class Donor extends StatefulWidget {
  @override
  _DonorState createState() => _DonorState();
}

class _DonorState extends State<Donor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Here 4 Hygiene'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Location'),
              leading: Icon(Icons.map_outlined),
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.23,
                child: Center(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(
                            Icons.add_box,
                            color: Colors.blue,
                          ),
                          title: Text('New Donation'),
                          subtitle: Text('Donate hygine and sanitary products'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('Proceed'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Itempage()));
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
            Container(
                height: MediaQuery.of(context).size.height * 0.23,
                child: Center(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(
                            Icons.verified,
                            color: Colors.green,
                          ),
                          title: Text('Previous donations'),
                          subtitle: Text('View your previous donations'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('View'),
                              onPressed: () {/* ... */},
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
            Container(
                height: MediaQuery.of(context).size.height * 0.23,
                child: Center(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(
                            Icons.history,
                            color: Colors.yellow,
                          ),
                          title: Text('Donations in progress'),
                          subtitle: Text(
                              'View all donations which are yet to be verified'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('View'),
                              onPressed: () {
                                return getData();
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
