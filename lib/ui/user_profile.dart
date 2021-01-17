import 'package:atamnirbharapp/bloc/user_details.dart';
import 'package:atamnirbharapp/bloc/user_repo.dart';
import 'package:atamnirbharapp/ui/home_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  var userNameController;

  var emailController;

  var numberController;

  var bioController = TextEditingController();

  var birthdayController;
  UserRepository userRepository = new UserRepository();
  String username, email, phonenumber, bio, birthdate, userId;

  var userDetails = UserDetails();
  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: _scaffoldKey.currentContext,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1950),
        lastDate: new DateTime.now());
    String pickedDate = new DateFormat('yyyy.MM.dd').format(picked.toLocal());
    if (picked != null)
      setState(() {
        birthdate = pickedDate;
      });
    birthdayController = TextEditingController(text: pickedDate);
  }

  getUserData(userId) async {
    await userRepository.getUserById(userId).then((value) => {
          setState(() {
            userDetails = UserDetails.fromJson(value.data());
            userNameController = TextEditingController(text: userDetails.name);
            emailController = TextEditingController(text: userDetails.email);
            numberController =
                TextEditingController(text: userDetails.phonenumber);
            birthdayController =
                TextEditingController(text: userDetails.birthdate);
            bioController = TextEditingController(text: userDetails.bio);
          })
        });
  }

  @override
  void initState() {
    userId = _auth.currentUser.uid;
    getUserData(userId);

    super.initState();
  }

  @override
  dispose() {
    userNameController.dispose();
    emailController.dispose();
    numberController.dispose();
    birthdayController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Image.asset("assets/images/Final_AatmNirbhar_logo.png"),
              iconSize: 70,
              onPressed: () {},
            ),
          ],
          leading: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()))),
          elevation: 10,
          backgroundColor: Colors.orange[50],
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        key: _scaffoldKey,
        body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/BG_Color.jpeg"),
                  fit: BoxFit.cover,
                )),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  _auth.currentUser.photoURL != null
                                      ? NetworkImage(
                                          _auth.currentUser.photoURL,
                                        )
                                      : Icon(Icons.face),
                              radius: 50.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                enabled: false,
                                autocorrect: true,
                                controller: userNameController,
                                onSaved: (newValue) {
                                  username = newValue;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.white,
                                child: TextFormField(
                                  enabled: false,
                                  autocorrect: true,
                                  controller: emailController,
                                  onSaved: (newValue) {
                                    email = newValue;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                    hintText: "Enter your email Id",
                                    fillColor: Colors.orange[50],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.white,
                                child: TextFormField(
                                  enabled: true,
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Please enter details";
                                    return null;
                                  },
                                  autocorrect: true,
                                  controller: numberController,
                                  onSaved: (newValue) {
                                    phonenumber = newValue;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.call,
                                      color: Colors.grey,
                                    ),
                                    hintText: "Enter your Phone number",
                                    fillColor: Colors.orange[50],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  _selectDate();
                                },
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: Colors.white,
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return "Please enter details";
                                        else
                                          return null;
                                      },
                                      autocorrect: true,
                                      controller: birthdayController,
                                      onSaved: (newValue) {},
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.date_range,
                                          color: Colors.grey,
                                        ),
                                        hintText: "Please enter your birthdate",
                                        fillColor: Colors.orange[50],
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.white,
                                child: TextFormField(
                                  autocorrect: true,
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Please enter details";
                                    else
                                      return null;
                                  },
                                  controller: bioController,
                                  onSaved: (newValue) {
                                    bio = newValue;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.description,
                                      color: Colors.grey,
                                    ),
                                    hintText: "Describe yourself",
                                    fillColor: Colors.orange[50],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  maxLines: null,
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  if (_formKey.currentState.validate()) {
                                    userDetails.phonenumber =
                                        numberController.text;
                                    userDetails.bio = bioController.text;
                                    userDetails.birthdate =
                                        birthdayController.text;
                                    await userRepository
                                        .addOrUpdateUser(userDetails);
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.white,
                                      content: Text(
                                        "Record succesfully updated.",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ));
                                  }
                                },
                                child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 0, 0, 136),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    margin: EdgeInsets.all(8),
                                    child: Center(
                                      child: Text(
                                        "Update",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )))
                          ],
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
