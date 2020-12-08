import 'package:atamnirbharapp/bloc/product.dart';
import 'package:atamnirbharapp/bloc/product_repo.dart';
import 'package:atamnirbharapp/ui/components/alternate_container.dart';

import 'package:atamnirbharapp/ui/components/innerpageappbar.dart';
import 'package:atamnirbharapp/ui/components/middlelogorow.dart';
import 'package:atamnirbharapp/ui/components/peoplewidget.dart';
import 'package:atamnirbharapp/ui/components/product_header.dart';

import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:atamnirbharapp/ui/screens/addcompany.dart';
import 'package:atamnirbharapp/ui/userauthentication/loginpage.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForeinProductPage extends StatelessWidget {
  final String productId;

  ForeinProductPage({Key key, @required this.productId}) : super(key: key);
  var productRepo = ProductRepository();
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
                  future: productRepo.getProduct(productId),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CommanWidgets()
                            .getCircularProgressIndicator(context);
                      default:
                        if (snapshot.hasData) {
                          Product product =
                              Product.fromJson(snapshot.data.first.data());
                          return CustomScrollView(slivers: [
                            InnerSliverAppBar(scaffoldKey: _scaffoldKey),
                            SliverList(
                                delegate: SliverChildListDelegate([
                              ProductHeader(
                                product: product,
                              ),
                              Container(
                                height: 120,
                                child: MiddleRow(
                                  company: product,
                                ),
                              ),
                              AlternateContainer(context, product),
                              PeopleRow(
                                company: product,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                AddCompany()));
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
                        } else if (snapshot.hasError)
                          return Center(child: Text("Loading.."));
                    }
                  }))),
    );
  }
}
