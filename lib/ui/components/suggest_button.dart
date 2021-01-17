import 'package:atamnirbharapp/bloc/company.dart';
import 'package:atamnirbharapp/bloc/product.dart';
import 'package:atamnirbharapp/ui/reviews/add_review.dart';
import 'package:atamnirbharapp/ui/screens/suggest_change_product.dart';
import 'package:atamnirbharapp/ui/screens/suggest_changes.dart';
import 'package:atamnirbharapp/ui/userauthentication/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuggestButton extends StatelessWidget {
  final Company company;
  final Product product;

  final String buttonName;
  SuggestButton({this.company, this.buttonName, this.product});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_auth.currentUser != null) {
          switch (buttonName) {
            case "Suggest Changes":
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => company == null
                          ? SuggestChangesProduct(product: product)
                          : SuggestChanges(company: company)));
              break;
            case "Add Review / Comment":
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => company == null
                          ? AddReview(product.id, _auth.currentUser.uid,
                              _auth.currentUser.displayName)
                          : AddReview(company.id, _auth.currentUser.uid,
                              _auth.currentUser.displayName)));
              break;
            case "Close":
              Navigator.pop(context);
              break;
            default:
              break;
          }
        } else {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => LoginPage()));
        }
      },
      child: Container(
        child: Center(
            child: SingleChildScrollView(
          child: Text(buttonName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        )),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.42,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 136),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        margin: EdgeInsets.all(8),
      ),
    );
  }
}
