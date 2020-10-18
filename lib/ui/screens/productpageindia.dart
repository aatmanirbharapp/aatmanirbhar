import 'package:atamnirbharapp/ui/components/innerpageappbar.dart';
import 'package:atamnirbharapp/ui/components/middlelogorow.dart';
import 'package:atamnirbharapp/ui/components/peoplewidget.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:flutter/material.dart';

class IndiaProductPage extends StatelessWidget {
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

class ProductHeader extends StatelessWidget {
  const ProductHeader({
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
                    "Bajaj Nomarks Ayurveda Antimarks \nSunscreen.",
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
                      Icon(Icons.add_shopping_cart),
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
