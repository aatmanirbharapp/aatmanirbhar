import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/company_repo.dart';
import 'package:atamnirbharapp/ui/components/company_header.dart';
import 'package:atamnirbharapp/ui/components/innerpageappbar.dart';
import 'package:atamnirbharapp/ui/components/middlelogosShowCase.dart';
import 'package:atamnirbharapp/ui/components/review_list.dart';
import 'package:atamnirbharapp/ui/components/similar_indian_components.dart';
import 'package:atamnirbharapp/ui/components/suggest_button.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:translator/translator.dart';

class IndianCompany extends StatelessWidget {
  final String companyId;
  final translator = GoogleTranslator();
  final langCode = 'en';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  IndianCompany({Key key, @required this.companyId}) : super(key: key);
  final companyRepo = CompanyRepository();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GlobalKey _first = GlobalKey();
  GlobalKey _second = GlobalKey();
  GlobalKey _three = GlobalKey();

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(CommanWidgets.PREFERENCES_IS_FIRST_LAUNCH_COMPANY_PAGE) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          CommanWidgets.PREFERENCES_IS_FIRST_LAUNCH_COMPANY_PAGE, false);

    return isFirstLaunch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerClass(),
        body: ShowCaseWidget(builder: Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _isFirstLaunch().then((result) {
              if (result)
                ShowCaseWidget.of(context)
                    .startShowCase([_first, _second, _three]);
            });
          });
          return Container(
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
                          company.id = snapshot.data.first.id;
                          return CustomScrollView(slivers: [
                            InnerSliverAppBar(scaffoldKey: this._scaffoldKey),
                            SliverList(
                                delegate: SliverChildListDelegate([
                              CompanyHeader(
                                company: company,
                                firstKey: _first,
                              ),
                              Container(
                                height: 150,
                                child: MiddleRow(
                                  firstCountry: company.firstCountry,
                                  secondCountry: company.secondCountry,
                                  makesInIndia: company.makesInIndia,
                                  sedKey: _second,
                                ),
                              ),
                              Container(
                                height: 200,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 2, color: Colors.black38)),
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    children: [
                                      Text("company_about".tr().toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Ambit',
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 0, 0, 136))),
                                      FutureBuilder<Translation>(
                                          future: translator.translate(
                                              company.aboutCompany,
                                              to: context.locale.languageCode),
                                          builder: (context, snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.waiting:
                                                return CommanWidgets()
                                                    .getCircularProgressIndicator(
                                                        context);
                                              default:
                                                if (snapshot.hasData) {
                                                  return Text(
                                                      "\n\n" +
                                                          snapshot.data.text,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        color: Colors.black,
                                                      ));
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text(
                                                          "Loading ..."));
                                                } else {
                                                  return Center(
                                                      child: Text(
                                                          "Loading ..."));
                                                }
                                            }
                                          })
                                    ]),
                              ),
                              Showcase(
                                key: _three,
                                title: "Indian Company",
                                description:
                                    "Choose Indian alternatives for this company",
                                child: SimilarIndianCompanies(
                                  company: company,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text("company_top".tr().toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Ambit',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 136))),
                              ),
                              ReviewList(
                                companyId: company.id,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SuggestButton(
                                      company: company,
                                      buttonName: "Suggest Changes",
                                    ),
                                    SuggestButton(
                                      company: company,
                                      buttonName: "Add Review / Comment",
                                    )
                                  ]),
                            ]))
                          ]);
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error occured"));
                        } else {
                          return Center(child: Text("Error occured"));
                        }
                    }
                  }));
        })));
  }
}
