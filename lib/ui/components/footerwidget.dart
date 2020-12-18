import 'package:atamnirbharapp/ui/aboutus.dart';
import 'package:atamnirbharapp/ui/faq.dart';
import 'package:atamnirbharapp/ui/helpandsupport.dart';
import 'package:atamnirbharapp/ui/privacy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
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
                    onPressed: () async {
                      const url = 'https://www.facebook.com/AatmanirbharApp';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter),
                    color: Colors.blue,
                    onPressed: () async {
                      const url = 'https://twitter.com/AatmanirbharApp';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.youtube),
                    color: Colors.red,
                    onPressed: () async {
                      const url =
                          'https://www.youtube.com/channel/UCLGwlyZLYuCd_i2dDHZmTcw';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
                IconButton(
                    color: Colors.red,
                    icon: FaIcon(FontAwesomeIcons.instagram),
                    onPressed: () async {
                      const url = 'https://www.instagram.com/japanisawapi/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin),
                    color: Colors.blue,
                    onPressed: () async {
                      const url =
                          'https://www.linkedin.com/in/aatmanirbharteam/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Aboutus()));
                  },
                  child: Text("About Us",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold))),
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Faq()));
                  },
                  child: Text("FAQs",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold))),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Privacy()));
                  },
                  child: Text("Privacy Policy",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold))),
              
            ],
          ),
          Divider(),
          Text(
            "Copyright © 2020 The Aatmanirbhar Trust. Created by Yash Agrawal",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ]));
  }
}
