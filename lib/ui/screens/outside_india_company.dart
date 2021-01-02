import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/company_repo.dart';
import 'package:atamnirbharapp/ui/components/company_header.dart';
import 'package:atamnirbharapp/ui/components/innerpageappbar.dart';
import 'package:atamnirbharapp/ui/components/middlelogorow.dart';

import 'package:atamnirbharapp/ui/components/review_list.dart';
import 'package:atamnirbharapp/ui/components/similar_indian_components.dart';
import 'package:atamnirbharapp/ui/components/suggest_button.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OutsideIndiaCompany extends StatelessWidget {
  final String companyId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  OutsideIndiaCompany({Key key, @required this.companyId}) : super(key: key);

  final companyRepo = CompanyRepository();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerClass(),
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
              child: FutureBuilder<List<QueryDocumentSnapshot>>(
                  future: companyRepo.getCompany(companyId),
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
                            InnerSliverAppBar(scaffoldKey: _scaffoldKey),
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
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(2),
                                    children: [
                                      Text("About Company",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Ambit',
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 0, 0, 136))),
                                      Text("\n\n" + company.aboutCompany,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            color: Colors.grey,
                                          ))
                                    ]),
                              ),
                              SimilarIndianCompanies(
                                company: company,
                              ),
                              SuggestButton(
                                company: company,
                                buttonName: "Suggest Changes",
                              ),
                              ReviewList(
                                id: company.id,
                              ),
                              SuggestButton(
                                company: company,
                                buttonName: "Add Review/Comments",
                              )
                            ]))
                          ]);
                        } else
                          return Center(child: Text("Loading ..."));
                    }
                  }))),
    );
  }
}
