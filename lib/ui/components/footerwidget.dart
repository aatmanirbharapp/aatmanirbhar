import 'package:atamnirbharapp/ui/aboutus.dart';
import 'package:atamnirbharapp/ui/faq.dart';
import 'package:atamnirbharapp/ui/privacy.dart';
import 'package:atamnirbharapp/ui/screens/report_bug.dart';
import 'package:atamnirbharapp/ui/terms_of_user.dart';
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                      const url = 'https://www.instagram.com/aatmanirbhar.app/';
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Aboutus(),
                        settings: RouteSettings(name: 'aboutUs')));
                  },
                  child: Text(
                    "About Us",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 136),
                        fontFamily: 'Ambit',
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Faq(),
                        settings: RouteSettings(name: 'faq')));
                  },
                  child: Text(
                    "FAQs",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 136),
                        fontFamily: 'Ambit',
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Privacy(),
                        settings: RouteSettings(name: 'privacy')));
                  },
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 136),
                        fontFamily: 'Ambit',
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Terms(),
                        settings: RouteSettings(name: 'terms')));
                  },
                  child: Text(
                    "Terms Of Use",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 136),
                        fontFamily: 'Ambit',
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReportBug(),
                        settings: RouteSettings(name: 'feedback')));
                  },
                  child: Text(
                    "Feedback",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 136),
                        fontFamily: 'Ambit',
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Divider(),
          Row(children: [
            Text(
              "Copyright © 2020 The Aatmanirbhar Trust.",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 136),
                  fontFamily: 'Ambit',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            InkWell(
              onTap: () async {
                const url =
                    'https://www.linkedin.com/in/yash-agrawal-9b936aa9/';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text(
                "Created by Yash Agrawal",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 136),
                    fontFamily: 'Ambit',
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ])
        ]));
  }
}
