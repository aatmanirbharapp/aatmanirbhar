import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/product.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MiddleRow extends StatefulWidget {
  @override
  _MiddleRowState createState() => _MiddleRowState();

  final int makesInIndia;

  final String firstCountry;
  final String secondCountry;

  const MiddleRow(
      {Key key, this.firstCountry, this.makesInIndia, this.secondCountry})
      : super(key: key);
}

class _MiddleRowState extends State<MiddleRow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => widget.makesInIndia == 1
              ? getPopUp(context, "Makes in India",
                  "This company makes in India, which includes one or more of the following activities: manufacturing, assembling, and providing services in India.")
              : getPopUp(context, "Imported",
                  "This company imports products to India from another country."),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                margin: EdgeInsets.only(left: 25, right: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: widget.makesInIndia == 1
                    ? Image.asset("assets/images/MakesInIndia_Logo.png")
                    : Image.asset("assets/images/Imported_Icon.png"),
              ),
              widget.makesInIndia == 1
                  ? RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Makes ",
                          children: [
                            TextSpan(
                                text: "In India",
                                style: TextStyle(color: Colors.green))
                          ],
                          style: TextStyle(color: Colors.orange)),
                    )
                  : RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Imported",
                          style: TextStyle(color: Colors.red)),
                    )
            ],
          ),
        ),
        GestureDetector(
          onTap: () => widget.firstCountry.contains("India")
              ? getPopUp(context, "Prefer This",
                  "We encourage the user to choose this company as India benefits from this company to a good extent.")
              : getPopUp(context, "Prefer Alternatives",
                  "We encourage the user to choose Indian alternatives for this company (shown below on this page) as India does not benefit substantially from this company. Similar Indian companies may offer similar quality products at competitive prices."),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                margin: EdgeInsets.only(left: 8, right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: widget.firstCountry.contains("India")
                    ? Image.asset("assets/images/PreferThis.png")
                    : Image.asset("assets/images/alternatives_icon.png"),
              ),
              widget.firstCountry.contains("India")
                  ? RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Prefer ",
                          children: [
                            TextSpan(
                                text: "This",
                                style: TextStyle(color: Colors.green))
                          ],
                          style: TextStyle(color: Colors.orange)),
                    )
                  : RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Prefer Alternatives ",
                          style: TextStyle(color: Colors.red)),
                    )
            ],
          ),
        ),
        widget.secondCountry.isEmpty
            ? GestureDetector(
                onTap: () => getPopUp(context, "Country",
                    "The country (countries) shown here benefit the most out of this company."),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                        margin: EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: widget.firstCountry.contains("India")
                            ? Image.asset("assets/images/Indian_Flag.png")
                            : FutureBuilder<Object>(
                                future: FirebaseStorage.instance
                                    .ref()
                                    .child("Country_Flags/Flag_" +
                                        widget.firstCountry +
                                        ".png")
                                    .getDownloadURL(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData)
                                    return ClipOval(
                                      child: Image.network(
                                        snapshot.data,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  return CommanWidgets()
                                      .getCircularProgressIndicator(context);
                                })),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: SingleChildScrollView(
                            child: Text(
                          widget.firstCountry,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 136),
                              fontSize: 15),
                        )))
                  ],
                ))
            : GestureDetector(
                onTap: () => getPopUp(context, "Country",
                    "The country (countries) shown here benefit the most out of this company."),
                child: CarouselSlider(
                  items: [
                    getSecondCompany(widget.firstCountry, context),
                    getSecondCompany(widget.secondCountry, context)
                  ],
                  options: CarouselOptions(autoPlay: true, aspectRatio: 1.2),
                ))
      ],
    );
  }
}

Widget getSecondCompany(String companyName, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
          height: MediaQuery.of(context).size.width * 0.15,
          width: MediaQuery.of(context).size.width * 0.15,
          margin: EdgeInsets.only(left: 25, right: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: companyName.contains("India")
              ? Image.asset("assets/images/Indian_Flag.png")
              : FutureBuilder<Object>(
                  future: FirebaseStorage.instance
                      .ref()
                      .child("Country_Flags/Flag_" + companyName + ".png")
                      .getDownloadURL(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return ClipOval(
                        child: Image.network(
                          snapshot.data,
                          fit: BoxFit.fill,
                        ),
                      );
                    return CommanWidgets()
                        .getCircularProgressIndicator(context);
                  })),
      Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: SingleChildScrollView(
              child: Text(
            companyName,
            maxLines: null,
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.visible,
            style:
                TextStyle(color: Color.fromARGB(255, 0, 0, 136), fontSize: 15),
          )))
    ],
  );
}

getPopUp(BuildContext context, String title, String content) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: Color.fromARGB(255, 0, 0, 136),
              child: Text("Close"),
              onPressed: () => Navigator.pop(context),
            )
          ],
          title: Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Ambit',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 136))),
          content: Text(content,
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.grey[700],
              )),
        );
      });
}
