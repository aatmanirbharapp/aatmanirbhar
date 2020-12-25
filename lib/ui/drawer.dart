import 'package:atamnirbharapp/ui/aboutus.dart';
import 'package:atamnirbharapp/ui/faq.dart';
import 'package:atamnirbharapp/ui/helpandsupport.dart';
import 'package:atamnirbharapp/ui/home_page.dart';
import 'package:atamnirbharapp/ui/privacy.dart';
import 'package:atamnirbharapp/ui/screens/addcompany.dart';
import 'package:atamnirbharapp/ui/user_profile.dart';
import 'package:atamnirbharapp/ui/userauthentication/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerClass extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
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
              _auth.currentUser != null
                  ? new ListTile(
                      onTap: () => Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => UserProfile())),
                      title: new Text(_auth.currentUser.displayName != null
                          ? _auth.currentUser.displayName
                          : _auth.currentUser.phoneNumber),
                      leading: new Icon(Icons.face),
                      trailing: new Icon(Icons.arrow_right),
                    )
                  : new ListTile(
                      onTap: () => Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => LoginPage())),
                      title: new Text("Login"),
                      leading: new Icon(Icons.login),
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
                    MaterialPageRoute(builder: (context) => AddCompany())),
                title: new Text("Add Company"),
                leading: new Icon(Icons.add_box),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Privacy())),
                title: new Text("Privacy Policy"),
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
                title: new Text("FAQs"),
                leading: new Icon(Icons.question_answer),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              if (_auth.currentUser != null)
                new ListTile(
                  onTap: () async {
                    await _auth.signOut();
                    await _googleSignIn.signOut();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => LoginPage()));
                  },
                  title: new Text("Logout"),
                  leading: new Icon(Icons.logout),
                  trailing: new Icon(Icons.arrow_right),
                ),
            ],
          ),
        ));
  }
}
