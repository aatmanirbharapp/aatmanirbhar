import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/http/faqrequest.dart';
import 'package:atamnirbharapp/ui/reviews/review_screen.dart';
import 'package:atamnirbharapp/ui/screens/comapny_product_list.dart';
import 'package:atamnirbharapp/ui/screens/show_web_view.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CompanyHeader extends StatelessWidget {
  final Company company;

  CompanyHeader({Key key, this.company}) : super(key: key);

  final _httpReq = SqlResponse();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black26)),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: FutureBuilder<Object>(
                future: FirebaseStorage.instance
                    .ref()
                    .child("Company_Logos/" + company.image)
                    .getDownloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return IconButton(
                        iconSize: MediaQuery.of(context).size.width,
                        icon: Image.network(snapshot.data),
                        onPressed: () {});
                  return CommanWidgets().getCircularProgressIndicator(context);
                }),
          ),
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65 - 50,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          company.companyName,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          maxLines: null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AllReview(object: company)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 136),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1)),
                          height: 25,
                          width: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder(
                                  future: _httpReq
                                      .getRatingCount(company.companyId),
                                  // ignore: missing_return
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Text("0.0",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white));
                                      default:
                                        if (snapshot.hasData) {
                                          return Text("4.2",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white));
                                        } else if (snapshot.hasError)
                                          return Text("0.0",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white));
                                    }
                                  }),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => WebViewPage(
                                            url: company.website,
                                          )));
                                },
                                child: Image.asset(
                                    "assets/images/Website_Icon.png")),
                          ),
                        ),
                        Text("Website",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 0, 0, 136)))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => WebViewPage(
                                            url: company.wikiPage,
                                          )));
                                },
                                child: Image.asset(
                                    "assets/images/Wikipedia_Icon.png")),
                          ),
                        ),
                        Text("Wikipedia",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 0, 0, 136)))
                      ],
                    ),
                    if (company.firstCountry.contains("India"))
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: InkWell(
                                  onTap: () {
                                    showAboutDialog(
                                        context: context,
                                        applicationName: "Facts And Stories",
                                        children: [
                                          Text(
                                            company.story,
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            maxLines: null,
                                          )
                                        ]);
                                  },
                                  child: Image.asset(
                                      "assets/images/Fact_Icon.png")),
                            ),
                          ),
                          Text("Story & Facts",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 0, 0, 136)))
                        ],
                      ),
                    if (company.isService == 0)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CompanyProductList(
                                            company: company,
                                          ),
                                        ));
                                  },
                                  child: Image.asset(
                                    "assets/images/Products_Icon.png",
                                    color: Color.fromARGB(255, 0, 0, 136),
                                  )),
                            ),
                          ),
                          Text("Products",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 0, 0, 136)))
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
