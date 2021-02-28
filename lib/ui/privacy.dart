import 'package:atamnirbharapp/bloc/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class Privacy extends StatelessWidget {
  final _faqGetRequest = CommanGetCalls();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          actions: [
            IconButton(
              icon: Image.asset("assets/images/Final_Aatmanirbhar_Logo.png"),
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
          title: Text("Privacy Policy",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Ambit',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 136)))),
      body: FutureBuilder<QuerySnapshot>(
          future: _faqGetRequest.getPrivacy(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Container(
                        padding: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/images/BG_Color.jpeg"),
                          fit: BoxFit.cover,
                        )),
                        child: HtmlView(
                            data:
                                '${snapshot.data.docs.first.data()['description']}',
                            scrollable: true),
                      ),
                    ]))
                  ]);
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
                  backgroundColor: Colors.orangeAccent,
                  strokeWidth: 10,
                ),
              ),
            );
          }),
    );
  }
}
