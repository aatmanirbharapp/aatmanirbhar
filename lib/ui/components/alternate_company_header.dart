import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/ui/screens/forein_product_screen.dart';
import 'package:atamnirbharapp/ui/screens/india_product_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AlternateCompanyHeader extends StatelessWidget {
  final product;
  final Company company;

  AlternateCompanyHeader({Key key, this.product, this.company})
      : super(key: key);

  final FirebaseStorage storageRef = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        company.firstCountry.toLowerCase().contains("india")
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IndianProduct(
                          product: product,
                          company: company,
                        )))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ForeinProductPage(
                          product: product,
                          company: company,
                        )));
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black26)),
        height: 100,
        width: MediaQuery.of(context).size.width * 0.80,
        child: Row(
          children: [
            FutureBuilder<Object>(
                future: storageRef
                    .ref()
                    .child("Product_Images/" + product.image)
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
                      AutoSizeText(
                        product.productName,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
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
