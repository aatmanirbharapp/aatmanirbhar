import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:atamnirbharapp/bloc/user_details.dart';
import 'package:atamnirbharapp/bloc/user_repo.dart';
import 'package:atamnirbharapp/ui/userauthentication/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future signWithGoogle(BuildContext context) async {
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

  Future signWithApple(BuildContext context) async {
    if (!await AppleSignIn.isAvailable()) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
            "Apple sign in not supported on your device, please try using google sign in."),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return null; //Break from the program
    }

    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    switch (result.status) {
      case AuthorizationStatus.authorized:
        {
          final AppleIdCredential appleIdCredential = result.credential;

          OAuthProvider oAuthProvider = new OAuthProvider('apple.com');
          final AuthCredential credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken),
            accessToken:
                String.fromCharCodes(appleIdCredential.authorizationCode),
          );

          await _auth
              .signInWithCredential(credential)
              .then((value) => (value) async {
                    await userRepository
                        .getUserById(value.user.uid)
                        .then((value2) => {
                              if (!value2.exists)
                                {
                                  userRepository.addOrUpdateUser(UserDetails(
                                      uid: value.user.uid,
                                      name: "${appleIdCredential.fullName}",
                                      email: "${appleIdCredential.email}"))
                                }
                            });
                  });
          break;
        }
      case AuthorizationStatus.error:
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Error occured please try again later"),
          backgroundColor: Theme.of(context).errorColor,
        ));
        break;

      case AuthorizationStatus.cancelled:
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Sign in cancelled")));

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      key: _scaffoldKey,
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
                              "assets/images/Final_Aatmanirbhar_Logo.png")),
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
                      child: Builder(
                        builder: (BuildContext context) => InkWell(
                            onTap: () async {
                              await signWithGoogle(context);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("login_success".tr().toString(),
                                    style: TextStyle(
                                        fontFamily: 'Ambit',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 136))),
                                backgroundColor: Colors.white,
                              ));

                              Future.delayed(Duration(seconds: 3)).then((_) {
                                Navigator.pop(context);
                              });
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
                                  "login_google".tr().toString(),
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Container(
                      height: 58,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: Builder(
                        builder: (BuildContext context) => InkWell(
                            onTap: () async {
                              await signWithApple(context);
                              if (!_auth.currentUser.isAnonymous) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Logged in successful",
                                      style: TextStyle(
                                          fontFamily: 'Ambit',
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 0, 0, 136))),
                                  backgroundColor: Colors.white,
                                ));

                                Future.delayed(Duration(seconds: 3)).then((_) {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  alignment: Alignment.topCenter,
                                  icon: FaIcon(
                                    FontAwesomeIcons.apple,
                                    color: Colors.white,
                                  ),
                                  iconSize: 40,
                                  onPressed: null,
                                ),
                                Text(
                                  "login_apple".tr().toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            )),
                      ),
                    ),
                  ) /*
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
