import 'package:atamnirbharapp/components/sliverappbarwidget.dart';
import 'package:atamnirbharapp/drawer.dart';
import 'package:atamnirbharapp/fancyfab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
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
            ]),
          )),
    ); // TODO: implement build
    throw UnimplementedError();
  }
}
