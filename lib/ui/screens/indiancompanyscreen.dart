import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/company_repo.dart';
import 'package:atamnirbharapp/ui/components/company_header.dart';
import 'package:atamnirbharapp/ui/components/innerpageappbar.dart';
import 'package:atamnirbharapp/ui/components/middlelogorow.dart';
import 'package:atamnirbharapp/ui/components/peoplewidget.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:atamnirbharapp/ui/screens/addcompany.dart';
import 'package:atamnirbharapp/ui/userauthentication/loginpage.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IndianCompany extends StatelessWidget {
  final String companyId;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  IndianCompany({Key key, @required this.companyId}) : super(key: key);
  final companyRepo = CompanyRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerClass(),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/BG_Color.jpeg"),
            fit: BoxFit.cover,
          )),
          child: FutureBuilder<List<QueryDocumentSnapshot>>(
              future: companyRepo.getCompany(companyId.split('.').first),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CommanWidgets()
                        .getCircularProgressIndicator(context);
                  default:
                    if (snapshot.hasData) {
                      Company company =
                          Company.fromJson(snapshot.data.first.data());
                      return CustomScrollView(slivers: [
                        InnerSliverAppBar(scaffoldKey: this._scaffoldKey),
                        SliverList(
                            delegate: SliverChildListDelegate([
                          CompanyHeader(
                            company: company,
                          ),
                          Container(
                            height: 120,
                            child: MiddleRow(
                              company: company,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: Colors.black38)),
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "About Company",
                                    children: [
                                      TextSpan(
                                          text: "\n\n" + company.aboutCompany,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600))
                                    ],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(37, 14, 98, 1))),
                              )
                            ]),
                          ),
                          PeopleRow(
                            company: company,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_auth.currentUser != null) {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => AddCompany()));
                              } else {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              }
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Suggest Changes",
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
                                  colors: [
                                    Colors.orange[100],
                                    Colors.green[100]
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              margin: EdgeInsets.all(20),
                            ),
                          )
                        ]))
                      ]);
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error occured"));
                    }
                }
              })),
    );
  }
}
