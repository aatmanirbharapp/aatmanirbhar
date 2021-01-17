import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/company_repo.dart';
import 'package:atamnirbharapp/bloc/user_company.dart';
import 'package:atamnirbharapp/bloc/user_details.dart';
import 'package:atamnirbharapp/bloc/user_repo.dart';
import 'package:atamnirbharapp/ui/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class SuggestChanges extends StatefulWidget {
  final Company company;
  @override
  _SuggestChangesState createState() => _SuggestChangesState();
  const SuggestChanges({this.company});
}

class _SuggestChangesState extends State<SuggestChanges> {
  var _scafolldKey = GlobalKey<ScaffoldState>();

  CompanyRepository _companyRepository = CompanyRepository();

  TextEditingController name,
      website,
      country,
      keyPerson,
      wikiUrl,
      facts,
      description,
      comments,
      sector,
      userName,
      userEmail;

  int makesInIndia;
  var formkey = GlobalKey<FormState>();
  Country _selected;
  var radioValue = 1;
  bool isLoading = false;
  UserDetails userDetails;
  UserRepository userRepository = new UserRepository();

  BuildContext context;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.company.companyName);
    website = TextEditingController(text: widget.company.website);
    wikiUrl = TextEditingController(text: widget.company.wikiPage);
    country = TextEditingController(text: widget.company.firstCountry);
    description = TextEditingController(text: widget.company.aboutCompany);
    sector = TextEditingController(text: widget.company.sector);
    comments = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() => this.context = context);
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
                        alignment: Alignment.topCenter,
                        child: IconButton(
                            iconSize: MediaQuery.of(context).size.height * 0.2,
                            onPressed: () {},
                            icon: Image.asset(
                                "assets/images/Final_AatmNirbhar_logo.png")),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Suggest Changes",
                            style: TextStyle(
                                fontFamily: 'Ambit',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 136),
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
                              _websitePage(),
                              _enterSector(),
                              _description(),
                              _comments()
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
                                var company = UserData(
                                    name: name.text,
                                    website: website.text,
                                    sector: sector.text,
                                    wikiPage: wikiUrl.text,
                                    description: description.text,
                                    comments: comments.text);
                                setState(() {
                                  isLoading = true;
                                });

                                await _companyRepository
                                    .addOrUpdateUserData(company)
                                    .then((value) => {
                                          setState(() {
                                            isLoading = false;
                                          }),
                                          Navigator.pop(context),
                                          Navigator.of(this.context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyHomePage()))
                                        })
                                    .catchError((error) => {
                                          setState(() {
                                            isLoading = false;
                                          }),
                                          Scaffold.of(this.context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor:
                                                Theme.of(this.context)
                                                    .errorColor,
                                            content: Text(
                                                "Failed to add company, Please try to sumbit again"),
                                          ))
                                        });
                              } else {
                                Scaffold.of(this.context).showSnackBar(SnackBar(
                                  backgroundColor: Theme.of(context).errorColor,
                                  content: Text(
                                      "Failed to add company, Image is not selected"),
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
        enabled: false,
        controller: name,
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
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.text_fields,
            color: Colors.grey,
          ),
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
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: country,
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
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.flag_outlined,
            color: Colors.grey,
          ),
          fillColor: Colors.orange[50],
          labelText: "Country",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _wikiPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: wikiUrl,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.url,
        autocorrect: true,
        cursorHeight: 10,
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

  Widget _enterSector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: sector,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        cursorHeight: 10,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.category,
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
        controller: website,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.url,
        autocorrect: true,
        cursorHeight: 10,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.link,
            color: Colors.grey,
          ),
          hintText: "Website Link",
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

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: description,
        maxLines: null,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        cursorHeight: 10,
        validator: (String value) {
          if (value == null || value.isEmpty)
            return "Please enter valid Description";
          return null;
        },
        decoration: InputDecoration(
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

  Widget _comments() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: comments,
        maxLines: null,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
        keyboardType: TextInputType.text,
        autocorrect: true,
        cursorHeight: 10,
        validator: (String value) {
          if (value == null || value.isEmpty)
            return "Please enter valid Description";
          return null;
        },
        decoration: InputDecoration(
          fillColor: Colors.orange[50],
          labelText: "Comments",
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
