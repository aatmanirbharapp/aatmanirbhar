import 'package:atamnirbharapp/ui/home_page.dart';
import 'package:flutter/material.dart';

class AuthUsingEmail extends StatefulWidget {
  @override
  _AuthUsingEmailState createState() => _AuthUsingEmailState();
}

class _AuthUsingEmailState extends State<AuthUsingEmail> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        autocorrect: true,
                        validator: (val) {
                          if (val.length == 0) {
                            return "Email cant be empty";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.call,
                            color: Colors.grey,
                          ),
                          hintText: "Enter Email id",
                          fillColor: Colors.orange[50],
                          labelText: "Email",
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                        keyboardType: TextInputType.number,
                        controller: _passwordController,
                        autocorrect: true,
                        validator: (val) {
                          if (val.length >= 0) {
                            return "Password cant be empty or not less than 8";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.call,
                            color: Colors.grey,
                          ),
                          hintText: "Enter password atleast 8 characters",
                          fillColor: Colors.orange[50],
                          labelText: "Password",
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => MyHomePage()));
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
            ]),
          )),
    );
  }
}
