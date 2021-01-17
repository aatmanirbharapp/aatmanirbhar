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

class DrawerClass extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
                              builder: (context) => UserProfilePage())),
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
                      leading: new Icon(Icons.face),
                      trailing: new Icon(Icons.arrow_right),
                    )
                  : new ListTile(
                      onTap: () => Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => LoginPage())),
                      title: new Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 136),
                            fontFamily: 'Ambit',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: new Icon(Icons.login),
                      trailing: new Icon(Icons.arrow_right),
                    ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyHomePage())),
                title: new Text(
                  "Dashboard",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.list),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => {
                  if (_auth.currentUser != null)
                    {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddCompany()))
                    }
                  else
                    {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please login first to add company",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold)),
                          backgroundColor: Theme.of(context).errorColor,
                        ),
                      )
                    }
                },
                title: new Text(
                  "Add Company",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.add_box),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Privacy())),
                title: new Text(
                  "Privacy Policy",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.security),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Terms())),
                title: new Text(
                  "Terms Of Use",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.description),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Aboutus())),
                title: new Text(
                  "About Us",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.exit_to_app),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              new ListTile(
                onTap: () => Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) => Faq())),
                title: new Text(
                  "FAQs",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 136),
                      fontFamily: 'Ambit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                leading: new Icon(Icons.question_answer),
                trailing: new Icon(Icons.arrow_right),
              ),
              Divider(),
              if (_auth.currentUser != null)
                new ListTile(
                  onTap: () async {
                    await _auth.signOut();
                    await _googleSignIn.signOut();

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  },
                  title: new Text(
                    "Logout",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 136),
                        fontFamily: 'Ambit',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: new Icon(Icons.logout),
                  trailing: new Icon(Icons.arrow_right),
                ),
            ],
          ),
        ));
  }
}
