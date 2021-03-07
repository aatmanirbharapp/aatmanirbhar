import 'dart:io';

import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/company_repo.dart';
import 'package:atamnirbharapp/bloc/user_details.dart';
import 'package:atamnirbharapp/bloc/user_repo.dart';
import 'package:atamnirbharapp/ui/home_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddCompany extends StatefulWidget {
  @override
  _AddCompanyState createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  FirebaseFirestore store = FirebaseFirestore.instance;
  var _scafolldKey = GlobalKey<ScaffoldState>();

  CompanyRepository _companyRepository = CompanyRepository();
  String name,
      website,
      keyPerson,
      wikiUrl,
      facts,
      description,
      sector,
      fileUrl,
      userName,
      userEmail,
  cin;

  int makesInIndia;
  var formkey = GlobalKey<FormState>();
  PickedFile image;
  Country _selected;
  var radioValue = 1;
  bool isLoading = false;
  UserDetails userDetails;
  var userNameController;
  UserRepository userRepository = new UserRepository();
  var emailController;

  _imgFromCamera() {
    setState(() async {
      image = await ImagePicker().getImage(source: ImageSource.camera);
    });
  }

  _imgFromGallery() {
    setState(() async {
      image = await ImagePicker().getImage(source: ImageSource.gallery);
    });
  }

  Future storeImage(File imageFile) async {
    var fileName = basename(image.path);
    print('Inside Store method' + fileName);
    FirebaseStorage.instance.ref().child(fileName).putFile(File(image.path));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafolldKey,
      body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/BG_Color.jpeg"),
                fit: BoxFit.cover,
              )),
              child: isLoading
                  ? Center(
                      heightFactor: 20,
                      widthFactor: 20,
                      child: CircularProgressIndicator(
                        value: 10,
                        backgroundColor: Colors.orange,
                      ),
                    )
                  : ListView(children: [
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                            iconSize: MediaQuery.of(context).size.height * 0.2,
                            onPressed: () {},
                            icon: Image.asset(
                                "assets/images/Final_Aatmanirbhar_Logo.png")),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Add Company/Products",
                            style: TextStyle(
                                fontFamily: 'Ambit',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 136)),
                          ),
                        ),
                      ),
                      Form(
                        key: formkey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              _companyName(),
                              _enterCin(),
                              _selectCountry(),
                              _radioButton(),
                              _wikiPage(),
                              _websitePage(),
                              _enterSector(),
                              //_factsAndStories(),
                              //_description()
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 30),
                        child: ButtonTheme(
                          height: 50,
                          child: FlatButton(
                            onPressed: () async {
                              if (formkey.currentState.validate()) {
                                formkey.currentState.save();
                                var company = Company(
                                    companyName: name,
                                    cin: cin,
                                    website: website,
                                    country: _selected.toString(),
                                    keyPerson: keyPerson,
                                    sector: sector,
                                    wikiPage: wikiUrl,
                                    makesInIndia: makesInIndia);
                                setState(() {
                                  isLoading = true;
                                });
                                //await storeImage(File(image.path));

                                await _companyRepository
                                    .addOrUpdateCompany(company)
                                    .then((value) => {
                                          setState(() {
                                            isLoading = false;
                                          }),
                                  Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Thank you! The company information you shared has been received by our team. Once it is approved by our team, this company will be available in the Aatmanirbhar app.",
                                                style: TextStyle(
                                                    fontFamily: 'Ambit',
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 136))),
                                            backgroundColor: Colors.white,
                                          )),
                                          Future.delayed(Duration(seconds: 3))
                                              .then((_) {
                                            Navigator.pop(context);
                                            Navigator.of(this.context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyHomePage()));
                                          }),
                                        })
                                    .catchError((error) => {
                                          setState(() {
                                            isLoading = false;
                                          }),
                                  Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor:
                                                Theme.of(this.context)
                                                    .errorColor,
                                            content: Text(
                                                "Sorry! We were unable to add your company information due to some technical issue. Please try again or visit this page later to add the company"),
                                          ))
                                        });
                              } else {
                                Scaffold.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Theme.of(context).errorColor,
                                  content: Text(
                                      "Please check and enter missing required field"),
                                ));
                              }
                            },
                            child: Center(
                                child: Text(
                              "Add".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 136, 1),
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
                      )
                    ]))),
    );
  }

  Widget _companyName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        cursorHeight: 10,
        validator: (String value) {
          if (value == null || value.isEmpty) return "Please enter valid Name";
          return null;
        },
        onSaved: (value) {
          name = value;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.featured_play_list,
            color: Colors.grey,
          ),
          hintText: "Enter Company's/Product's Name",
          fillColor: Colors.orange[50],
          labelText: "Name",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _selectCountry() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Benefiting Country :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          Spacer(
            flex: 3,
          ),
          Center(
            child: CountryPicker(
              nameTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              onChanged: (Country country) {
                setState(() {
                  _selected = country;
                });
              },
              selectedCountry: _selected,
            ),
          ),
          Spacer()
        ],
      ),
    );
  }

  Widget _wikiPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.url,
        autocorrect: true,
        cursorHeight: 10,
        onSaved: (value) {
          wikiUrl = value;
        },
        validator: (String value) {
          if (value == null || value.isEmpty)
            return "Please enter valid wikipedia Page";
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.link,
            color: Colors.grey,
          ),
          hintText: "Company's Wikipedia link/ If not then NA",
          fillColor: Colors.orange[50],
          labelText: "Wikipedia Link",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _radioButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Makes In India :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text("Yes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Radio(
            value: 1,
            groupValue: radioValue,
            onChanged: (value) {
              setState(() {
                radioValue = value;
                makesInIndia = value;
              });
            },
          ),
          Text("No",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Radio(
            value: 0,
            groupValue: radioValue,
            onChanged: (value) {
              setState(() {
                radioValue = value;
                makesInIndia = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _enterSector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        cursorHeight: 10,
        onSaved: (value) {
          sector = value;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.featured_play_list,
            color: Colors.grey,
          ),
          hintText: "Enter Sector ",
          fillColor: Colors.orange[50],
          labelText: "Sector",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }


  Widget _enterCin() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        cursorHeight: 10,
        onSaved: (value) {
          cin = value;
        },
        validator: (String value) {
          if (value == null || value.isEmpty)
            return "Please enter valid CIN Numbersss";
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.featured_play_list,
            color: Colors.grey,
          ),
          hintText: "Company Identification Number(CIN)",
          fillColor: Colors.orange[50],
          labelText: "CIN",
          labelStyle:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _websitePage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.url,
        autocorrect: true,
        cursorHeight: 10,
        onSaved: (value) {
          website = value;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.link,
            color: Colors.grey,
          ),
          hintText: "Website link/ If not then NA",
          fillColor: Colors.orange[50],
          labelText: "Website",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  _companyLogo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          "Upload Company Logo :",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        IconButton(
          key: _scafolldKey,
          onPressed: () {
            Scaffold.of(_scafolldKey.currentContext)
                .showSnackBar(SnackBar(
              backgroundColor: Colors.white,
              elevation: 5,
              content: Container(
                height: 200,
                width: MediaQuery.of(_scafolldKey.currentContext).size.width,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.photo_album,
                        color: Colors.black,
                      ),
                      title: Text("Upload Using gallery",
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        _imgFromGallery();
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.photo_camera, color: Colors.black),
                      title: Text("Take picture",
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        _imgFromCamera();
                      },
                    )
                  ],
                ),
              ),
            ));
          },
          icon: Icon(Icons.add_a_photo),
        )
      ]),
    );
  }

  Widget _factsAndStories() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        maxLines: null,
        cursorHeight: 10,
        onSaved: (value) {
          facts = value;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.amp_stories,
            color: Colors.grey,
          ),
          hintText: "Enter Facts and stories about company. (Optional)",
          fillColor: Colors.orange[50],
          labelText: "Facts & Stories",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: null,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        cursorHeight: 10,
        onSaved: (value) {
          description = value;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.description,
            color: Colors.grey,
          ),
          hintText: "Enter Description",
          fillColor: Colors.orange[50],
          labelText: "Description",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
