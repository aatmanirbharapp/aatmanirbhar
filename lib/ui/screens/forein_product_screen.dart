import 'package:atamnirbharapp/bloc/product.dart';
import 'package:atamnirbharapp/bloc/product_repo.dart';
import 'package:atamnirbharapp/ui/components/alternate_container.dart';

import 'package:atamnirbharapp/ui/components/innerpageappbar.dart';
import 'package:atamnirbharapp/ui/components/middlelogorow.dart';

import 'package:atamnirbharapp/ui/components/product_header.dart';
import 'package:atamnirbharapp/ui/components/review_list.dart';
import 'package:atamnirbharapp/ui/components/suggest_button.dart';

import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                          product.id = snapshot.data.first.id;
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
                                  firstCountry: product.firstCountry,
                                  secondCountry: product.secondCountry,
                                  makesInIndia: product.makeInIndia,
                                ),
                              ),
                              AlternateContainer(context, product),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text("Top Reviews",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Ambit',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 136))),
                              ),
                              ReviewList(
                                id: product.id,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SuggestButton(
                                      product: product,
                                      buttonName: "Suggest Changes",
                                    ),
                                    SuggestButton(
                                      product: product,
                                      buttonName: "Add Review / Comment",
                                    )
                                  ]),
                            ]))
                          ]);
                        } else if (snapshot.hasError)
                          return Center(child: Text("Loading.."));
                        else
                          return Center(child: Text("Loading.."));
                    }
                  }))),
    );
  }
}
