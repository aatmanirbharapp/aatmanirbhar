import 'package:atamnirbharapp/main.dart';
import 'package:atamnirbharapp/ui/userauthentication/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_otp/flutter_otp.dart' as otp;
import 'package:firebase_auth/firebase_auth.dart' as auth;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = TextEditingController();
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var onTapRecognizer;
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/BG_Color.jpeg"),
                fit: BoxFit.cover,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: IconButton(
                          iconSize: MediaQuery.of(context).size.height * 0.3,
                          onPressed: () {},
                          icon: Image.asset(
                              "assets/images/Final_AatmNirbhar_logo.png")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                        keyboardType: TextInputType.number,
                        controller: _controller,
                        autocorrect: true,
                        validator: (val) {
                          if (val.length == 0) {
                            return "Number cant be empty";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.call,
                            color: Colors.grey,
                          ),
                          hintText: "Enter Phone Number",
                          fillColor: Colors.orange[50],
                          labelText: "Mobile Number",
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          String number = "+91" + _controller.text.trim();

                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Verification(number)));
                        }
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.orange[100], Colors.green[100]],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        margin: EdgeInsets.all(20),
                      )),
                  FacebookSignInButton(
                    onPressed: () {},
                    borderRadius: 15,
                    centered: true,
                  ),
                  GoogleSignInButton(
                    onPressed: () {},
                    borderRadius: 10,
                    centered: true,
                  )
                ],
              ))),
    );
  }
}
