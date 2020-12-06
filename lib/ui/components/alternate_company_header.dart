import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/product.dart';
import 'package:atamnirbharapp/ui/screens/forein_product_screen.dart';
import 'package:atamnirbharapp/ui/screens/india_product_screen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AlternateCompanyHeader extends StatelessWidget {
  final Product product;

  AlternateCompanyHeader({Key key, this.product}) : super(key: key);

  final FirebaseStorage storageRef = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        product.firstCountry.toLowerCase().contains("india")
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IndianProduct(
                          productId: product.image,
                        )))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ForeinProductPage(productId: product.image)));
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65 - 50,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            product.productName,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            maxLines: null,
                          ),
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
