import 'package:atamnirbharapp/bloc/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  final CommanGetCalls _firebaseCall = CommanGetCalls();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Image.asset("assets/images/Final_AatmNirbhar_logo.png"),
            iconSize: 70,
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 10,
        backgroundColor: Colors.orange[50],
        centerTitle: true,
        title: Text(
          "FAQs",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: _firebaseCall.getFaq(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/BG_Color.jpeg"),
                    fit: BoxFit.cover,
                  )),
                  child: HtmlView(
                      data: '${snapshot.data.docs.first.data()['description']}',
                      scrollable: true),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/BG_Color.jpeg"),
                fit: BoxFit.cover,
              )),
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                  strokeWidth: 5,
                ),
              ),
            );
          }),
    );
  }
}
