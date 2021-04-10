import 'package:atamnirbharapp/bloc/product.dart';
import 'package:atamnirbharapp/bloc/product_repo.dart';

import 'package:atamnirbharapp/ui/components/alternate_product_header.dart';
import 'package:atamnirbharapp/ui/screens/product_list_bykeyword.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
Widget AlternateContainer(BuildContext context, Product product) {
  var productRepo = ProductRepository();

  return Container(
    margin: EdgeInsets.all(8),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black26)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "product_alternate".tr().toString(),
                style: TextStyle(
                    fontFamily: 'ambit',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 136)),
              ),
              InkWell(
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => ProductListByKeyWord(
                            product: product,
                          ),
                      settings: RouteSettings(name: 'productList'))),
                  child: Text("product_view".tr().toString(),
                      style: TextStyle(
                          fontFamily: 'ambit',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 136)))),
            ],
          ),
        ),
        FutureBuilder<List<QueryDocumentSnapshot>>(
            future: productRepo.getProductByKeyword(product.manufacture, 3),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemExtent: 100,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product com = Product.fromJson(
                          snapshot.data.elementAt(index).data());
                      return AlternateProductHeader(
                        product: com,
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("Error Occured");
              } else
                return CommanWidgets().getCircularProgressIndicator(context);
            })
      ],
    ),
  );
}
