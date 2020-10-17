import 'package:atamnirbharapp/aboutus.dart';
import 'package:atamnirbharapp/faq.dart';
import 'package:atamnirbharapp/helpandsupport.dart';
import 'package:atamnirbharapp/main.dart';
import 'package:atamnirbharapp/privacy.dart';
import 'package:atamnirbharapp/user_profile.dart';
import 'package:atamnirbharapp/userauthentication/loginpage.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DrawerClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/BG_Color.jpeg"),
            fit: BoxFit.cover,
          )),
          child: new ListView(
            children: <Widget>[
              new ListTile(
                onTap: () => Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => LoginPage())),
                title: new Text("Yash"),
                subtitle: Text("agrawaly52@gmail.com"),
                leading: new Icon(
                  EvaIcons.personAddOutline,
                ),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyHomePage())),
                title: new Text("Dashboard"),
                leading: new Icon(Icons.list),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HelpAndSupport())),
                title: new Text("Help And Suppor"),
                leading: new Icon(Icons.help),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Privacy())),
                title: new Text("Privacy Terms and Conditions"),
                leading: new Icon(Icons.security),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Aboutus())),
                title: new Text("About Us"),
                leading: new Icon(Icons.exit_to_app),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) => Faq())),
                title: new Text("FAQ"),
                leading: new Icon(Icons.help),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
            ],
          ),
        ));
  }
}
