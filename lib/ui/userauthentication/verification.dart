import 'dart:async';

import 'package:atamnirbharapp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verification extends StatefulWidget {
  final String number;

  Verification(this.number);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  var onTapRecognizer;
  final textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    errorController.close();
    // TODO: implement dispose
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
                    ),
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
                              onChanged: null)),
                    ),
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
                              registerUser(widget.number,
                                  textEditingController.text, context);
                              // Triggering error shake animation
                              setState(() {
                                isLoading = true;
                              });
                            } else {
                              errorController.add(ErrorAnimationType.shake);
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

  Future registerUser(String mobile, String otp, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) async {
          await _auth.signInWithCredential(authCredential);
        },
        verificationFailed: (FirebaseAuthException authException) {
          setState(() {
            isLoading = false;
            SnackBar(
              content: Text("Invalid OTP " + authException.message),
            );
          });
        },
        codeSent: (String verificationId, int resendToken) async {
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: otp);

          await _auth
              .signInWithCredential(phoneAuthCredential)
              .then((value) => {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MyHomePage()))
                  })
              .catchError((error) => {
                    setState(() {
                      isLoading = false;
                      SnackBar(
                        content: Text("Invalid OTP " + error),
                      );
                    })
                  });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }
}
