import 'package:atamnirbharapp/ui/components/sliverappbarwidget.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
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
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [],
                          text:
                              "In April 2020, our team took the initiative of transforming the way Indian consumers buy the products. With the Aatmanirbhar Bharat campaign launched by the Government of India, under the leadership of Prime Minister Modi, our team decided to focus on creating an Aatmanirbhar ecosystem that will support its vision of self-reliance. For this purpose, our goal is to bring awareness about Indian (swadeshi) companies so that Indian consumers are encouraged to buy made-in-India products.We believe that in a democracy, the power of the people is supreme. We, the people, can change the Indian economy by changing our buying habits. The government is doing their part, we will do ours.")),
                )
              ])),
            ]),
          )),
    );
  }
}
