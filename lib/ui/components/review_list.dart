import 'package:atamnirbharapp/bloc/review.dart';
import 'package:atamnirbharapp/bloc/review_repo.dart';

import 'package:atamnirbharapp/ui/reviews/review_container.dart';

import 'package:atamnirbharapp/utils/comman_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  String userId, companyId;
  FirebaseAuth auth = FirebaseAuth.instance;
  ReviewList({this.userId, this.companyId});

  final reviewRepo = ReviewRepo();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot>>(
      future: companyId != null && companyId.isNotEmpty
          ? reviewRepo.getReviewByCompanyId(companyId)
          : reviewRepo.getReviewByUserId(userId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CommanWidgets().getCircularProgressIndicator(context);
          default:
            if (snapshot.hasData) {
              return snapshot.data.length != 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(5),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      physics:
                          ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                      itemBuilder: (context, int index) {
                        Review review = Review.fromJson(
                            snapshot.data.elementAt(index).data());

                        return review.enable == 1 || userId != null
                            ? ReviewContainer(review)
                            : Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                    review.userName +
                                        " Your review is in Pending status ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Ambit',
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 0, 0, 136))));
                      },
                    )
                  : Text("Be the first to add comments/review.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Ambit',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 136)));
            } else {
              return Align(
                alignment: Alignment.center,
                child: Text("Loading .. "),
              );
            }
        }
      },
    );
  }
}
