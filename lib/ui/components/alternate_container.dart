import 'package:atamnirbharapp/bloc/product.dart';
import 'package:atamnirbharapp/bloc/product_repo.dart';
import 'package:atamnirbharapp/ui/components/alternate_company_header.dart';
import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget AlternateContainer(BuildContext context, Product product) {
  var productRepo = ProductRepository();

  return Container(
    margin: EdgeInsets.all(8),
    height: 380,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black26)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Alternative Indian Companies",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(child: Text("View All")),
            ],
          ),
        ),
        FutureBuilder<List<QueryDocumentSnapshot>>(
            future: productRepo.getProductByKeyword(product.manufacture),
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
                      return AlternateCompanyHeader(
                        product: com,
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("Error Occured");
              } else
                return CommanWidgets().getCircularProgressIndicator();
            })
      ],
    ),
  );
}
