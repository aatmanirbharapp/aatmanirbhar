import 'dart:io';

import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/ui/screens/indiancompanyscreen.dart';
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
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var websiteController = TextEditingController();
  var keyPersonController = TextEditingController();
  var wikipediaController = TextEditingController();
  var factsController = TextEditingController();
  var descriptionController = TextEditingController();
  var sectorController = TextEditingController();
  PickedFile image;
  var website;
  String fileUrl;
  Country _selected;
  var radioValue = 1;

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
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);

    StorageUploadTask ref = firebaseStorageRef.putFile(File(image.path));
    var storageTaskSnapshot = await ref.onComplete;
    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    setState(() {
      fileUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: ListView(children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: IconButton(
                      iconSize: MediaQuery.of(context).size.height * 0.2,
                      onPressed: () {},
                      icon: Image.asset(
                          "assets/images/Final_AatmNirbhar_logo.png")),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Add Company",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: 20),
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
                        _selectCountry(),
                        _radioButton(),
                        _wikiPage(),
                        _keyPerson(),
                        _websitePage(),
                        _enterSector(),
                        _companyLogo(),
                        _factsAndStories(),
                        _description()
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
                          await storeImage(File(image.path));
                          var company = Company(
                              name: nameController.text,
                              website: website,
                              country: _selected,
                              keyPerson: keyPersonController.text,
                              sector: sectorController.text,
                              stories: factsController.text,
                              description: descriptionController.text,
                              logoFileName: fileUrl);

                          await store
                              .collection("company")
                              .add(company.toJson())
                              .then((value) => {
                                    CircularProgressIndicator(),
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => IndianCompany(
                                                companyName:
                                                    nameController.text)),
                                        (route) => false)
                                  })
                              .catchError((value) => {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      backgroundColor:
                                          Theme.of(context).errorColor,
                                      content: Text(
                                          "Failed to add company, Please Try Again!"),
                                    ))
                                  });
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
        controller: nameController,
        validator: (String value) {
          if (value == null || value.isEmpty) return "Please enter valid Name";
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.featured_play_list,
            color: Colors.grey,
          ),
          hintText: "Enter Company Name",
          fillColor: Colors.orange[50],
          labelText: "Company Name",
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
          Spacer(),
          Text(
            "Origin Country :",
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
        controller: wikipediaController,
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
          hintText: "Enter Company Wikipedia link",
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
        controller: sectorController,
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
        controller: websiteController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.link,
            color: Colors.grey,
          ),
          hintText: "Website Link",
          fillColor: Colors.orange[50],
          labelText: "Company Website",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _keyPerson() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        cursorHeight: 10,
        controller: keyPersonController,
        validator: (String value) {
          if (value == null || value.isEmpty) return "Please enter valid Name";
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.face,
            color: Colors.grey,
          ),
          hintText: "Enter Key Person name",
          fillColor: Colors.orange[50],
          labelText: "Company Owner",
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
            Scaffold.of(_scafolldKey.currentContext).showSnackBar(SnackBar(
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
        controller: factsController,
        validator: (String value) {
          if (value == null || value.isEmpty)
            return "Please enter valid Stroies ";
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.amp_stories,
            color: Colors.grey,
          ),
          hintText: "Enter Facts and stories about company",
          fillColor: Colors.orange[50],
          labelText: "Company Facts & Stroies.",
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
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        cursorHeight: 10,
        controller: descriptionController,
        validator: (String value) {
          if (value == null || value.isEmpty)
            return "Please enter valid Description";
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.description,
            color: Colors.grey,
          ),
          hintText: "Enter Company Description",
          fillColor: Colors.orange[50],
          labelText: "Company Description",
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
