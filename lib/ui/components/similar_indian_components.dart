import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/company_repo.dart';
import 'package:atamnirbharapp/ui/components/alternate_company_header.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SimilarIndianCompanies extends StatelessWidget {
  Company company;

  SimilarIndianCompanies({this.company});

  final companyRepo = CompanyRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text("Similar Indian Companies",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ambit',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 136))),
          ),
          Container(
              height: 120,
              child: FutureBuilder<List<QueryDocumentSnapshot>>(
                future: companyRepo.getCompanyListBySector(
                    company.sector, company.companyName),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CommanWidgets()
                          .getCircularProgressIndicator(context);
                    default:
                      if (snapshot.hasData) {
                        return snapshot.data.length == 0
                            ? Text("No Similar Companies found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Ambit',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 136)))
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, int index) {
                                  return AlternateCompanyHeader(
                                    company: Company.fromJson(
                                        snapshot.data.elementAt(index).data()),
                                  );
                                });
                      } else {
                        return Text(
                            "No Similar companies found for sector " +
                                company.sector,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Ambit',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 136)));
                      }
                  }
                },
              )),
        ],
      ),
    );
  }
}
