import 'package:atamnirbharapp/bloc/review.dart';
import 'package:flutter/material.dart';

class ReviewContainer extends StatelessWidget {
  final Review review;

  const ReviewContainer(this.review);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      review.userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(review.dateTime)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.title,
                      textAlign: TextAlign.left,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        review.description,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.visible,
                        maxLines: null,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
