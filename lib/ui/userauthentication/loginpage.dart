import 'package:atamnirbharapp/bloc/user_details.dart';
import 'package:atamnirbharapp/bloc/user_repo.dart';
import 'package:atamnirbharapp/ui/home_page.dart';

import 'package:atamnirbharapp/ui/userauthentication/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var onTapRecognizer;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String username, email;
  UserDetails user;

  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    super.initState();
  }

  Future signWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _auth.signInWithCredential(authCredential).then((value) async {
      await userRepository.getUserById(value.user.uid).then((value2) => {
            if (!value2.exists)
              {
                userRepository.addOrUpdateUser(UserDetails(
                    uid: value.user.uid,
                    name: value.user.displayName,
                    email: value.user.email))
              }
          });
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
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: 58,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: InkWell(
                          onTap: () async {
                            await signWithGoogle();

                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Image.asset("assets/images/glogo.png"),
                                iconSize: 8,
                                onPressed: null,
                              ),
                              Text(
                                "Sign in with Google",
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ],
                          )),
                    ),
                  ), /* 
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text("Use Mobile Number to Login/Signup"),
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
                    ButtonWidget(formKey: _formKey, controller: _controller), */
                ],
              ))),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController controller,
  })  : _formKey = formKey,
        _controller = controller,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        ));
  }
}
