import 'package:atamnirbharapp/components/innerpageappbar.dart';
import 'package:atamnirbharapp/components/middlelogorow.dart';
import 'package:atamnirbharapp/components/peoplewidget.dart';
import 'package:atamnirbharapp/drawer.dart';
import 'package:atamnirbharapp/screens/productpageindia.dart';
import 'package:flutter/material.dart';

class ProductPageNonIndia extends StatelessWidget {
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
            child: CustomScrollView(slivers: [
              InnerSliverAppBar(scaffoldKey: _scaffoldKey),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        IconButton(
                            icon: Image.asset(
                                "assets/images/Final_AatmNirbhar_logo.png"),
                            iconSize: 150,
                            onPressed: () {}),
                        Text(
                          "Be Desi, Support Swadesi",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black26)),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ProductHeader(),
                ),
                Container(
                  height: 120,
                  child: MiddleRow(),
                ),
                PeopleRow(),
                MaterialButton(
                  color: Colors.green[100],
                  onPressed: () {},
                  child: Text("Suggest Changes"),
                )
              ]))
            ]),
          )),
    );
  }
}
