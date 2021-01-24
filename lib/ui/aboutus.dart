import 'package:atamnirbharapp/bloc/about_us.dart';
import 'package:atamnirbharapp/bloc/cloud_firestore.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutus extends StatelessWidget {
  final _faqGetRequest = CommanGetCalls();
  final storageRef = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
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
        title: Text("About Us",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Ambit',
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 136))),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/BG_Color.jpeg"),
          fit: BoxFit.cover,
        )),
        child: FutureBuilder<QuerySnapshot>(
            future: _faqGetRequest.getAboutUs(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CommanWidgets().getCircularProgressIndicator(context);
                default:
                  if (snapshot.hasData) {
                    AboutUs aboutUs =
                        AboutUs.fromJson(snapshot.data.docs.first.data());
                    return CustomScrollView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverList(
                              delegate: SliverChildListDelegate([
                            Container(
                                margin: EdgeInsets.all(8),
                                height: 250,
                                child: HtmlView(
                                    data: '${aboutUs.description}',
                                    scrollable: true)),
                            Divider(),
                            Text(
                              "Our Core Team",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Ambit',
                                  color: Color.fromARGB(255, 0, 0, 136),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Divider(),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(0)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(10)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(11)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(2)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(4)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(5)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(1)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(6)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(3)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(9)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(7)),
                            TeamHeader(
                                storageRef: storageRef,
                                team: aboutUs.team.elementAt(8)),
                            Divider(),
                            Container(
                                height: 250,
                                margin: EdgeInsets.all(8),
                                child: HtmlView(
                                    data: '${aboutUs.last}', scrollable: true)),
                          ])),
                        ]);
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error occured"));
                  } else {
                    return Center(child: Text("Error occured"));
                  }
              }
            }),
      ),
    );
  }
}

class TeamHeader extends StatelessWidget {
  const TeamHeader({Key key, @required this.storageRef, @required this.team})
      : super(key: key);

  final FirebaseStorage storageRef;
  final Map team;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: FutureBuilder<Object>(
                        future: storageRef
                            .ref()
                            .child("Team/" + team['image'])
                            .getDownloadURL(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData)
                            return ClipOval(
                              child: Image.network(
                                snapshot.data,
                                fit: BoxFit.cover,
                              ),
                            );
                          return CommanWidgets()
                              .getCircularProgressIndicator(context);
                        }),
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: () async {},
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              team['name'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Ambit',
                                  color: Color.fromARGB(255, 0, 0, 136),
                                  fontWeight: FontWeight.bold),
                            ),
                            if (team['url'] != null &&
                                team['url'].toString().isNotEmpty)
                              IconButton(
                                onPressed: () async {
                                  if (await canLaunch(team['url'])) {
                                    await launch(team['url']);
                                  } else {
                                    throw 'Could not launch ';
                                  }
                                },
                                icon: FaIcon(FontAwesomeIcons.linkedinIn),
                                iconSize: 15,
                                color: Color.fromARGB(255, 0, 0, 136),
                              )
                          ]),
                      SingleChildScrollView(
                          child: Text(
                        team['role'],
                        textAlign: TextAlign.center,
                      )),
                      Text(team['location'], textAlign: TextAlign.center)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
