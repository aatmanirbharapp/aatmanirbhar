import 'package:atamnirbharapp/aboutus.dart';
import 'package:atamnirbharapp/contact_us.dart';
import 'package:atamnirbharapp/faq.dart';
import 'package:atamnirbharapp/helpandsupport.dart';
import 'package:atamnirbharapp/privacy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook),
                    color: Colors.blue,
                    onPressed: () {}),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter),
                    color: Colors.blue,
                    onPressed: () {}),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.youtube),
                    color: Colors.red,
                    onPressed: () {}),
                IconButton(
                    color: Colors.red,
                    icon: FaIcon(FontAwesomeIcons.instagram),
                    onPressed: () {}),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin),
                    color: Colors.blue,
                    onPressed: () {}),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Aboutus()));
                  },
                  child: Text("About Us| ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold))),
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Faq()));
                  },
                  child: Text("FAQs|",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold))),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ContactUs()));
                  },
                  child: Text("Contact Us| ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold))),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Privacy()));
                  },
                  child: Text("Privacy Policy|",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold))),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HelpAndSupport()));
                  },
                  child: Text("Terms Of Use",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)))
            ],
          ),
          Text(
            " Copyright © Aatmanibhar Team| Created by: Yash ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ]));
  }
}
