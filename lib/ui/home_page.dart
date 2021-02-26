import 'package:atamnirbharapp/ui/components/footerwidget.dart';
import 'package:atamnirbharapp/ui/components/sliverappbarwidget.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:atamnirbharapp/ui/screens/homescreen.dart';

import 'package:flutter/material.dart';
import 'package:share/share.dart';

class MyHomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerClass(),
      body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/BG_Color.jpeg"),
              fit: BoxFit.cover,
            )),
            child: CustomScrollView(slivers: [
              CustomSliverAppBar(scaffoldKey: _scaffoldKey),
              SliverList(
                  delegate: SliverChildListDelegate(
                      [CompanyCardView(), FooterWidget()])),
            ]),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final RenderBox box = context.findRenderObject();
          Share.share(
              'Want to support made in India products that benefit India? Looking for Indian alternatives to foreign products? Want to support local businesses? Unaware of interesting aatmanirbhar stories and facts about Indian companies? Download and install The Aatmanirbhar App from the following link to find answers to all these questions. https://play.google.com/store/apps/details?id=com.aatmanirbhar.flutter',
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        },
        child: Icon(
          Icons.share_rounded,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 136),
      ),
    );
  }
}
