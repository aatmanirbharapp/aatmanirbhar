import 'package:atamnirbharapp/bloc/user_details.dart';
import 'package:atamnirbharapp/ui/user_profile.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:atamnirbharapp/bloc/user_repo.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var userRepository = new UserRepository();
  final FirebaseStorage storageRef = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserDetails userDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Image.asset("assets/images/Final_AatmNirbhar_logo.png"),
              iconSize: 70,
              onPressed: () {},
            ),
          ],
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 10,
          backgroundColor: Colors.orange[50],
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
                fontFamily: 'Ambit',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          future: userRepository.getUserById(_auth.currentUser.uid),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CommanWidgets().getCircularProgressIndicator(context);
              default:
                if (snapshot.hasData) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/images/BG_Color.jpeg"),
                        fit: BoxFit.cover,
                      )),
                      child: ListView(children: [
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black26)),
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    _auth.currentUser.photoURL != null
                                        ? NetworkImage(
                                            _auth.currentUser.photoURL,
                                          )
                                        : Icon(Icons.face),
                                radius: 50.0,
                              ),
                              Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Welcome Aatmanirbhar",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20,
                                          foreground: Paint()
                                            ..shader = ui.Gradient.linear(
                                              const Offset(60, 100),
                                              const Offset(50, 35),
                                              <Color>[
                                                Colors.orange,
                                                Colors.green,
                                              ],
                                            )),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65 -
                                              50,
                                          child: SingleChildScrollView(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              snapshot.data['name'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 136),
                                                  fontFamily: 'Ambit',
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              maxLines: null,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: Icon(
                                            Icons.edit,
                                            color:
                                                Color.fromARGB(255, 0, 0, 136),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserProfile()));
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: ListTile(
                              leading: Icon(Icons.email),
                              title: Text(snapshot.data['email'],
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Colors.black,
                                  )),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: ListTile(
                              leading: Icon(Icons.call),
                              title: Text(snapshot.data['phonenumber'],
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Colors.black,
                                  )),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: ListTile(
                              leading: Icon(Icons.date_range),
                              title: Text(snapshot.data['birthdate'],
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Colors.black,
                                  )),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Icon(Icons.info),
                              title: TextFormField(
                                enabled: false,
                                initialValue: snapshot.data['bio'],
                                maxLines: null,
                                style: new TextStyle(
                                  fontFamily: "OpenSans",
                                ),
                              ),
                            ))
                      ]));
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error occured"));
                } else {
                  return Center(child: Text("Error occured"));
                }
            }
          },
        ));
  }
}
