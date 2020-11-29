import 'package:atamnirbharapp/ui/components/footerwidget.dart';
import 'package:atamnirbharapp/ui/home_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Newly added Indian companies",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
                textAlign: TextAlign.left,
              ),
              Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.black)
            ],
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              items: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MyHomePage())),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset("assets/images/backimage.jpg"),
                        ),
                        Positioned(
                            bottom: 10,
                            left: 30,
                            child: Row(
                              children: [
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide()),
                                  color: Colors.blue[50],
                                  onPressed: () {},
                                  child: Text(
                                    "HERSHEYS",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset("assets/images/britannia.png"),
                    ),
                    Positioned(
                        bottom: 10,
                        left: 30,
                        child: Row(
                          children: [
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide()),
                              color: Colors.blue[50],
                              onPressed: () {},
                              child: Text(
                                "BRITANNIA",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ))
                  ],
                )
              ],
            )),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search by category",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
                textAlign: TextAlign.left,
              ),
              Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.black)
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.orange[50], Colors.green[50]],
                )),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset("assets/images/Cars.png"),
                  ),
                  Positioned(
                      left: 10,
                      bottom: 10,
                      child: Text(
                        "Automobiles ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ))
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Colors.orange[50], Colors.green[50]],
                  )),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset("assets/images/Toys.png"),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        FooterWidget()
      ],
    );
  }
}
