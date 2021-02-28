import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/product.dart';
import 'package:atamnirbharapp/bloc/product_repo.dart';

import 'package:atamnirbharapp/ui/components/alternate_product_header.dart';
import 'package:atamnirbharapp/ui/drawer.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompanyProductList extends StatelessWidget {
  final Company company;

  CompanyProductList({Key key, this.company});

  var productRepo = ProductRepository();
  @override
  Widget build(BuildContext context) {
    print(company.companyId);
    return Scaffold(
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
        title: Text("Products List",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Ambit',
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 136))),
      ),
      drawer: DrawerClass(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/BG_Color.jpeg"),
          fit: BoxFit.cover,
        )),
        child: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: productRepo.getAllProductsByCompanyId(company.companyId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return AlternateProductHeader(
                      product: Product.fromJson(
                          snapshot.data.elementAt(index).data()));
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error Occured"),
              );
            } else
              return CommanWidgets().getCircularProgressIndicator(context);
          },
        ),
      ),
    );
  }
}
