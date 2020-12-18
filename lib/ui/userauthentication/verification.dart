import 'dart:async';
import 'package:atamnirbharapp/ui/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Verification extends StatefulWidget {
  final String number;

  Verification(this.number);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  var onTapRecognizer;
  final textEditingController = TextEditingController();



  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  User _firebaseUser;
  String _status;

  AuthCredential _phoneAuthCredential;
  String _verificationId;

  bool isLoading = false;
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };

    super.initState();
    print(widget.number);
    _submitPhoneNumber();
  }

  void _handleError(e) {
    print(e.message);
    setState(() {
      _status += e.message + '\n';
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    //errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/BG_Color.jpeg"),
          fit: BoxFit.cover,
        )),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
                child: ListView(
                  children: [
                    IconButton(
                        iconSize: MediaQuery.of(context).size.height * 0.3,
                        onPressed: () {},
                        icon: Image.asset(
                            "assets/images/Final_AatmNirbhar_logo.png")),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Phone Number Verification',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8),
                      child: RichText(
                        text: TextSpan(
                            text: "Enter the code sent to ",
                            children: [
                              TextSpan(
                                  text: widget.number,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ],
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),/*
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Form(
                          key: formKey,
                          child: PinCodeTextField(
                              appContext: context,
                              length: 6,
                              backgroundColor: Colors.transparent,
                              controller: textEditingController,
                              errorAnimationController: errorController,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 60,
                                fieldWidth: 50,
                                activeFillColor: Colors.white,
                              ),
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              onChanged: null)),*/

                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Didn't receive the code? ",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                          children: [
                            TextSpan(
                                text: " RESEND",
                                recognizer: onTapRecognizer,
                                style: TextStyle(
                                    color: Color(0xFF91D3B3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))
                          ]),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      child: ButtonTheme(
                        height: 50,
                        child: FlatButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              _submitOTP();
                              if (_firebaseUser != null)
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyHomePage(),
                                    ));
                            } else {
                              //errorController.add(ErrorAnimationType.shake);
                            }
                          },
                          child: Center(
                              child: Text(
                            "VERIFY".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: Offset(1, -2),
                                blurRadius: 5),
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: Offset(-1, 2),
                                blurRadius: 5)
                          ]),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _login() async {
    /// This method is used to login the user
    /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
    /// After the signIn method from `AuthResult` we can get `FirebaserUser`(`_firebaseUser`)
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential)
          .then((authRes) {
        _firebaseUser = authRes.user;
      }).catchError((e) => _handleError(e));
      setState(() {
        _status += 'Signed In\n';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _logout() async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
      _firebaseUser = null;
      setState(() {
        _status += 'Signed out\n';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _submitPhoneNumber() async {
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      setState(() {
        _status += 'verificationCompleted\n';
      });
      this._phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException error) {
      print('verificationFailed');
      _handleError(error);
    }

    void codeSent(String verificationId, [int code]) {
      print('codeSent');
      this._verificationId = verificationId;
      print(verificationId);

      print(code.toString());
      setState(() {
        _status += 'Code Sent\n';
      });
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      setState(() {
        _status += 'codeAutoRetrievalTimeout\n';
      });
      print(verificationId);
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      /// Make sure to prefix with your country code
      phoneNumber: widget.number,

      /// `seconds` didn't work. The underlying implementation code only reads in `millisenconds`
      timeout: Duration(milliseconds: 10000),

      /// If the SIM (with phoneNumber) is in the current device this function is called.
      /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
      /// When this function is called there is no need to enter the OTP, you can click on Login button to sigin directly as the device is now verified
      verificationCompleted: verificationCompleted,

      /// Called when the verification is failed
      verificationFailed: verificationFailed,

      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent,

      /// After automatic code retrival `tmeout` this function is called
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }

  void _submitOTP() {
    /// get the `smsCode` from the user
    String smsCode = textEditingController.text.toString().trim();
    this._phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this._verificationId, smsCode: smsCode);

    _login();
  }
}
