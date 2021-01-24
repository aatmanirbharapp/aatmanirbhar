import 'package:atamnirbharapp/ui/components/footerwidget.dart';
import 'package:atamnirbharapp/ui/components/sliverappbarwidget.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:atamnirbharapp/ui/screens/homescreen.dart';

import 'package:flutter/material.dart';

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
    );
  }
}
