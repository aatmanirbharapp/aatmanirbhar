import 'package:atamnirbharapp/http/faqrequest.dart';
import 'package:atamnirbharapp/ui/components/sliverappbarwidget.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class Aboutus extends StatelessWidget {
  final _faqGetRequest = FaqHttpRequest();
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
          "About Us",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List>(
          future: _faqGetRequest.mapDataToState('aboutus'),
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
                      data: '${snapshot.data[0]["description"]}',
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
                  backgroundColor: Colors.blue,
                  strokeWidth: 15,
                ),
              ),
            );
          }),
    );
  }
}
