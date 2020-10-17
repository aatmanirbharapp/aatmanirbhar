import 'package:atamnirbharapp/components/innerpageappbar.dart';
import 'package:atamnirbharapp/components/middlelogorow.dart';
import 'package:atamnirbharapp/components/peoplewidget.dart';
import 'package:atamnirbharapp/components/sliverappbarwidget.dart';
import 'package:atamnirbharapp/drawer.dart';
import 'package:atamnirbharapp/screens/productpageindia.dart';
import 'package:flutter/material.dart';

class IndianCompany extends StatelessWidget {
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
                  child: CompanyHeader(),
                ),
                Container(
                  height: 120,
                  child: MiddleRow(),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black38)),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          "About Company",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ))
                  ]),
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

class CompanyHeader extends StatelessWidget {
  const CompanyHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: IconButton(
              iconSize: MediaQuery.of(context).size.width,
              icon: Image.asset("assets/images/Bajaj_Company_logo.png"),
              onPressed: () {}),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Bajaj Consumer care ltd.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        iconSize: 10,
                        icon: Image.asset("assets/images/Website_Icon.png"),
                        onPressed: () {},
                      ),
                      Text("Website", style: TextStyle(fontSize: 10))
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        iconSize: 15,
                        icon: Image.asset("assets/images/Wikipedia_Icon.png"),
                        onPressed: () {},
                      ),
                      Text("Wikipedia", style: TextStyle(fontSize: 10))
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          iconSize: 10,
                          icon: Image.asset("assets/images/Fact_Icon.png"),
                          onPressed: null),
                      Text("Story & Facts", style: TextStyle(fontSize: 10))
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () => Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => IndiaProductPage()))),
                      Text("Products", style: TextStyle(fontSize: 10))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
