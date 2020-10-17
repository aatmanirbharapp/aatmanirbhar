import 'package:atamnirbharapp/components/sliverappbarwidget.dart';

import 'package:atamnirbharapp/drawer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
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
                  delegate: SliverChildListDelegate([
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        text: 'Frequently Asked Questions: \n\n\n',
                        children: [
                      TextSpan(
                          text: "Q1) What is the purpose of this app?\n\n\n",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              "Ans: This app is built to support Government of India’s initiative to make India self-reliant and transform into a major exporter. The app aims at making Indian consumers better informed and to transform their buying habits. \nThe app has four unique features: \n1) it tells about the country that is primarily benefitting from a company or a product, \n2) for foreign companies and products the app provides Indian alternatives, \n3) inspiring and interesting stories/facts are shared through this app, and \n 4) the app provides a voice to the local companies for sharing about themselves and their products.")
                    ]))
              ]))
            ]),
          )),
    );
  }
}
