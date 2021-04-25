import 'package:atamnirbharapp/bloc/product.dart';
import 'package:atamnirbharapp/ui/screens/indiancompanyscreen.dart';
import 'package:atamnirbharapp/ui/screens/show_web_view.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class ProductHeader extends StatelessWidget {
  final Product product;
  final translator = GoogleTranslator();

  ProductHeader({Key key, this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black26)),
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: FutureBuilder<Object>(
                future: FirebaseStorage.instance
                    .ref()
                    .child("Product_Images/" + product.image)
                    .getDownloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return IconButton(
                        iconSize: MediaQuery.of(context).size.height,
                        icon: Image.network(snapshot.data),
                        onPressed: () {});
                  return CommanWidgets().getCircularProgressIndicator(context);
                }),
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65 - 50,
                      child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: 8),
                          child: FutureBuilder<Translation>(
                              future: translator.translate(product.productName,
                                  to: context.locale.languageCode),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return LinearProgressIndicator(
                                      value: 1,
                                      backgroundColor: Colors.transparent,
                                    );
                                  default:
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 0, 136),
                                            fontFamily: 'Ambit',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.visible,
                                        softWrap: true,
                                        maxLines: null,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(child: Text("Loading ..."));
                                    } else {
                                      return Center(child: Text("Loading ..."));
                                    }
                                }
                              })),
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
                                            url: product.website,
                                          ),
                                      settings:
                                          RouteSettings(name: 'webView')));
                                },
                                child: Image.asset(
                                    "assets/images/Website_Icon.png")),
                          ),
                        ),
                        Text("company_website".tr().toString(),
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 0, 0, 128)))
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
                                      builder: (context) => IndianCompany(
                                            companyId: product.companyId,
                                          ),
                                      settings:
                                          RouteSettings(name: 'company')));
                                },
                                child: FutureBuilder<Object>(
                                    future: FirebaseStorage.instance
                                        .ref()
                                        .child("Company_Logos/" +
                                            product.companyId +
                                            ".png")
                                        .getDownloadURL(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData)
                                        return Image.network(snapshot.data);

                                      return CommanWidgets()
                                          .getCircularProgressIndicator(
                                              context);
                                    }),
                              )),
                        ),
                        Text("company_link".tr().toString(),
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 0, 0, 128)))
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
