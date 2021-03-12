import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/http/faqrequest.dart';
import 'package:atamnirbharapp/ui/screens/comapny_product_list.dart';
import 'package:atamnirbharapp/ui/screens/show_web_view.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

class CompanyHeader extends StatelessWidget {
  final Company company;

  CompanyHeader({Key key, this.company}) : super(key: key);

  final _httpReq = SqlResponse();
  GlobalKey _three = GlobalKey();
  GlobalKey _fourth = GlobalKey();

  GlobalKey _five = GlobalKey();
  GlobalKey _six = GlobalKey();

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(CommanWidgets.PREFERENCES_IS_FIRST_LAUNCH_COMPANY_PAGE) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          CommanWidgets.PREFERENCES_IS_FIRST_LAUNCH_COMPANY_PAGE, false);

    return isFirstLaunch;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result)
          ShowCaseWidget.of(context)
              .startShowCase([_three, _fourth, _five, _six]);
      });
    });
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black26)),
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.30,
            child: FutureBuilder<Object>(
                future: FirebaseStorage.instance
                    .ref()
                    .child("Company_Logos/" + company.image)
                    .getDownloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) return Image.network(snapshot.data);

                  return CommanWidgets().getCircularProgressIndicator(context);
                }),
          ),
          Container(
            height: 140,
            width: MediaQuery.of(context).size.width * 0.60,
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
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 136),
                              fontFamily: 'Ambit',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          maxLines: null,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   AllReview(company.companyId)));
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           color: Color.fromARGB(255, 0, 0, 136),
                    //           borderRadius: BorderRadius.circular(5),
                    //           border: Border.all(width: 1)),
                    //       height: 25,
                    //       width: 40,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           FutureBuilder(
                    //               future: _httpReq
                    //                   .getRatingCount(company.companyId),
                    //               // ignore: missing_return
                    //               builder: (context, snapshot) {
                    //                 switch (snapshot.connectionState) {
                    //                   case ConnectionState.waiting:
                    //                     return Text("0.0",
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.bold,
                    //                             color: Colors.white));
                    //                   default:
                    //                     if (snapshot.hasData) {
                    //                       return Text("4.2",
                    //                           style: TextStyle(
                    //                               fontWeight: FontWeight.bold,
                    //                               color: Colors.white));
                    //                     } else if (snapshot.hasError)
                    //                       return Text("0.0",
                    //                           style: TextStyle(
                    //                               fontWeight: FontWeight.bold,
                    //                               color: Colors.white));
                    //                 }
                    //               }),
                    //           Icon(
                    //             Icons.star,
                    //             color: Colors.white,
                    //             size: 10,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WebViewPage(
                                url: company.website,
                              ),
                          settings: RouteSettings(name: 'webView'))),
                      child: Showcase(
                        key: _three,
                        title: 'Website Link',
                        description:
                            'Please click here to check company website',
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: InkWell(
                                    onTap: () {
                                      company.website.isEmpty
                                          ? AlertDialog(
                                              actions: [
                                                FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 136),
                                                  child: Text("Close"),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ],
                                              content: Text(
                                                  "No website page present for given company, If you found any link please suggest that changes",
                                                  style: TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    color: Colors.grey[700],
                                                  )),
                                            )
                                          : Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WebViewPage(
                                                        url: company.website,
                                                      ),
                                                  settings: RouteSettings(
                                                      name: 'webView')));
                                    },
                                    child: Image.asset(
                                        "assets/images/Website_Icon.png")),
                              ),
                            ),
                            Text("Website",
                                style: TextStyle(
                                    fontFamily: 'Ambit',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Color.fromARGB(255, 0, 0, 136)))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WebViewPage(
                                url: company.wikiPage,
                              ),
                          settings: RouteSettings(name: 'webView'))),
                      child: Showcase(
                        key: _fourth,
                        title: 'Wikipedia Link',
                        description:
                            'Please click here to check company wikipedia page.',
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: InkWell(
                                    onTap: () {
                                      company.wikiPage.isEmpty
                                          ? AlertDialog(
                                              actions: [
                                                FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 136),
                                                  child: Text("Close"),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ],
                                              content: Text(
                                                  "No wikipedia page present for given company, If you found any link please suggest that changes",
                                                  style: TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    color: Colors.grey[700],
                                                  )),
                                            )
                                          : Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WebViewPage(
                                                        url: company.wikiPage,
                                                      ),
                                                  settings: RouteSettings(
                                                      name: 'webView')));
                                    },
                                    child: Image.asset(
                                        "assets/images/Wikipedia_Icon.png")),
                              ),
                            ),
                            Text("Wikipedia",
                                style: TextStyle(
                                    fontFamily: 'Ambit',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Color.fromARGB(255, 0, 0, 136)))
                          ],
                        ),
                      ),
                    ),
                    if (company.firstCountry.contains("India"))
                      GestureDetector(
                        onTap: () => showDialog(
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
                                title: Text("Aatmanirbhar Story and Facts",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Ambit',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 136))),
                                content: Text(company.story,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      color: Colors.grey[700],
                                    )),
                              );
                            }),
                        child: Showcase(
                          key: _five,
                          title: 'Aatmanirbhar stories',
                          description:
                              'Check here interesting Aatmanirbhar stories',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                actions: [
                                                  FlatButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 136),
                                                    child: Text("Close"),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  )
                                                ],
                                                title: Text(
                                                    "Aatmanirbhar Story and Facts",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: 'Ambit',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 136))),
                                                content: Text(company.story,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: Colors.grey[700],
                                                    )),
                                              );
                                            });
                                      },
                                      child: Image.asset(
                                          "assets/images/Fact_Icon.png")),
                                ),
                              ),
                              Text("Facts",
                                  style: TextStyle(
                                      fontFamily: 'Ambit',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Color.fromARGB(255, 0, 0, 136)))
                            ],
                          ),
                        ),
                      ),
                    if (company.isService == 0)
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompanyProductList(
                                      company: company,
                                    ),
                                settings:
                                    RouteSettings(name: 'companyProductList'))),
                        child: Showcase(
                          key: _six,
                          title: 'Products',
                          description: 'Check here products of given company.',
                          child: Column(
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
                                                settings: RouteSettings(
                                                    name:
                                                        'companyProductList')));
                                      },
                                      child: Image.asset(
                                        "assets/images/Products_Icon.png",
                                        color: Color.fromARGB(255, 0, 0, 136),
                                      )),
                                ),
                              ),
                              Text("Products",
                                  style: TextStyle(
                                      fontFamily: 'Ambit',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Color.fromARGB(255, 0, 0, 136)))
                            ],
                          ),
                        ),
                      )
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
