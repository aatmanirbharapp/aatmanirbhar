import 'package:atamnirbharapp/ui/aboutus.dart';
import 'package:atamnirbharapp/ui/faq.dart';
import 'package:atamnirbharapp/ui/home_page.dart';
import 'package:atamnirbharapp/ui/privacy.dart';
import 'package:atamnirbharapp/ui/screens/addcompany.dart';
import 'package:atamnirbharapp/ui/screens/user_profile.dart';
import 'package:atamnirbharapp/ui/terms_of_user.dart';
import 'package:atamnirbharapp/ui/userauthentication/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';

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
              !_auth.currentUser.isAnonymous
                  ? new ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => UserProfilePage(),
                                settings: RouteSettings(name: 'userProfile')));
                      },
                      title: new Text(
                        _auth.currentUser.displayName != null
                            ? _auth.currentUser.displayName
                            : _auth.currentUser.phoneNumber,
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 136),
                            fontFamily: 'Ambit',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: new Icon(Icons.face,
                          color: Color.fromARGB(255, 0, 0, 136)),
                      trailing: new Icon(Icons.arrow_right,
                          color: Color.fromARGB(255, 0, 0, 136)),
                    )
                  : new ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => LoginPage(),
                                settings: RouteSettings(name: 'login')));
                      },
                      title: new Text(
                        "drawer_login".tr().toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 136),
                            fontFamily: 'Ambit',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: new Icon(Icons.login,
                          color: Color.fromARGB(255, 0, 0, 136)),
                      trailing: new Icon(Icons.arrow_right,
                          color: Color.fromARGB(255, 0, 0, 136)),
                    ),
              Divider(),
              new ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                      settings: RouteSettings(name: 'home')));
                },
                title: new Text(
                  "home".tr().toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 0, 0, 136),
                ),
                trailing: new Icon(Icons.arrow_right,
                    color: Color.fromARGB(255, 0, 0, 136)),
              ),
              Divider(),
              new ListTile(
                onTap: () => {
                  if (!_auth.currentUser.isAnonymous)
                    {
                      Navigator.pop(context),
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddCompany(),
                          settings: RouteSettings(name: 'addCompany')))
                    }
                  else
                    {
                      Navigator.pop(context),
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please login first to add company",
                              style: TextStyle(
                                  fontFamily: 'Ambit',
                                  fontWeight: FontWeight.bold)),
                          backgroundColor: Theme.of(context).errorColor,
                        ),
                      )
                    }
                },
                title: new Text(
                  "drawer_add".tr().toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.add_box,
                    color: Color.fromARGB(255, 0, 0, 136)),
                trailing: new Icon(Icons.arrow_right,
                    color: Color.fromARGB(255, 0, 0, 136)),
              ),
              Divider(),
              new ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Privacy(),
                      settings: RouteSettings(name: 'privacy')));
                },
                title: new Text(
                  "footer_privacy".tr().toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.security,
                    color: Color.fromARGB(255, 0, 0, 136)),
                trailing: new Icon(Icons.arrow_right,
                    color: Color.fromARGB(255, 0, 0, 136)),
              ),
              Divider(),
              new ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Terms(),
                      settings: RouteSettings(name: 'terms')));
                },
                title: new Text(
                  "footer_terms".tr().toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.description,
                    color: Color.fromARGB(255, 0, 0, 136)),
                trailing: new Icon(Icons.arrow_right,
                    color: Color.fromARGB(255, 0, 0, 136)),
              ),
              Divider(),
              new ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Aboutus(),
                      settings: RouteSettings(name: 'aboutUs')));
                },
                title: new Text(
                  "footer_about".tr().toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.exit_to_app,
                    color: Color.fromARGB(255, 0, 0, 136)),
                trailing: new Icon(Icons.arrow_right,
                    color: Color.fromARGB(255, 0, 0, 136)),
              ),
              Divider(),
              new ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => Faq(),
                      settings: RouteSettings(name: 'faq')));
                },
                title: new Text(
                  "footer_faq".tr().toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.question_answer,
                    color: Color.fromARGB(255, 0, 0, 136)),
                trailing: new Icon(Icons.arrow_right,
                    color: Color.fromARGB(255, 0, 0, 136)),
              ),
              Divider(),
              if (!_auth.currentUser.isAnonymous)
                new ListTile(
                  onTap: () async {
                    await _auth.signOut();
                    await _googleSignIn.signOut();
                    await _auth.signInAnonymously();
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => LoginPage(),
                            settings: RouteSettings(name: 'login')));
                  },
                  title: new Text(
                    "drawer_logout".tr().toString(),
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 136),
                        fontFamily: 'Ambit',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: new Icon(Icons.logout,
                      color: Color.fromARGB(255, 0, 0, 136)),
                  trailing: new Icon(Icons.arrow_right,
                      color: Color.fromARGB(255, 0, 0, 136)),
                ),
            ],
          ),
        ));
  }
}
