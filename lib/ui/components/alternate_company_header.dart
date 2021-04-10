import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/ui/screens/indiancompanyscreen.dart';
import 'package:atamnirbharapp/ui/screens/outside_india_company.dart';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:translator/translator.dart';
class AlternateCompanyHeader extends StatelessWidget {
  final Company company;

  AlternateCompanyHeader({Key key, this.company}) : super(key: key);
  final translator = GoogleTranslator();
  final FirebaseStorage storageRef = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(company.toJson());
        company.firstCountry.toLowerCase().contains("india")
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IndianCompany(
                          companyId: company.companyId,
                        )))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OutsideIndiaCompany(companyId: company.companyId)));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black26)),
        height: 100,
        child: Row(
          children: [
            FutureBuilder<Object>(
                future: storageRef
                    .ref()
                    .child("Company_Logos/" + company.image)
                    .getDownloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: IconButton(
                          iconSize: MediaQuery.of(context).size.width,
                          icon: Image.network(snapshot.data),
                          onPressed: () {}),
                    );
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: LinearProgressIndicator(
                      value: 5,
                      backgroundColor: Colors.red,
                    ),
                  );
                }),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.60,
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
                              future: translator.translate(company.companyName,
                                  from: 'en', to: 'hi'),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return LinearProgressIndicator(value: 1,backgroundColor: Colors.transparent,);
                                  default:
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 136),
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
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
