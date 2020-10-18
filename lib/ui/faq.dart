import 'package:atamnirbharapp/http/faqrequest.dart';
import 'package:atamnirbharapp/ui/components/sliverappbarwidget.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
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
          "FAQ's",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<List>(
          stream: _faqGetRequest.mapDataToState(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    strokeWidth: 15,
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');

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
            }
          }),
    );
  }
}
