import 'package:atamnirbharapp/bloc/review.dart';
import 'package:atamnirbharapp/bloc/review_repo.dart';

import 'package:atamnirbharapp/ui/home_page.dart';
import 'package:atamnirbharapp/ui/reviews/star_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddReview extends StatefulWidget {
  final String id;
  final String username;
  final String uid;

  AddReview(this.id, this.uid, this.username);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var _scafolldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final textEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

  final _httpReq = ReviewRepo();

  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafolldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        title: Text(
          "Add Review",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 136)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 0, 136),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Divider(),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: StarRating(
                        color: Color.fromARGB(255, 0, 0, 136),
                        rating: rating,
                        onRatingChanged: (rating) =>
                            setState(() => this.rating = rating),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                      keyboardType: TextInputType.text,
                      controller: textEditingController,
                      autocorrect: true,
                      validator: (val) {
                        if (val.length == 0) {
                          return "Title cant be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Title",
                        fillColor: Colors.orange[50],
                        labelText: "Title",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      controller: descriptionEditingController,
                      autocorrect: true,
                      validator: (val) {
                        if (val.length == 0) {
                          return "Description cant be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Description",
                        fillColor: Colors.orange[50],
                        labelText: "Description",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: () async {
                  if (formKey.currentState.validate()) {
                    var review = Review(
                      companyId: widget.id,
                      userId: widget.uid,
                      rating: rating,
                      userName: widget.username,
                      title: textEditingController.text,
                      description: descriptionEditingController.text,
                      dateTime: DateTime.now().toString(),
                      enable: 0,
                    );

                    await _firestore
                        .collection("reviews")
                        .add(review.toJson())
                        .then((value) => {
                      _scafolldKey.currentState
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "Your review has been successfully added. Please check your all reviews in profile section.",
                                    style: TextStyle(
                                        fontFamily: 'Ambit',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 136))),
                                backgroundColor: Colors.white,
                              )),
                              Future.delayed(Duration(seconds: 3)).then((_) {
                                Navigator.pop(context);
                                Navigator.of(this.context).push(
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                              }),
                            })
                        .catchError((error) => {
                      _scafolldKey.currentState
                                  .showSnackBar(SnackBar(
                                backgroundColor:
                                    Theme.of(this.context).errorColor,
                                content: Text(
                                    "We were unable to add your review due to some technical issue. Please try again or visit this page later to add review."),
                              ))
                            });
                  } else {
                    _scafolldKey.currentState.showSnackBar(SnackBar(
                      backgroundColor: Theme.of(context).errorColor,
                      content:
                          Text("Please check and enter missing required field"),
                    ));
                  }
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "Add review",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 136),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  margin: EdgeInsets.all(20),
                ))
          ],
        ),
      ),
    );
  }
}
