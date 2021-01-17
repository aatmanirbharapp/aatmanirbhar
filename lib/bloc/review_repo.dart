import 'package:atamnirbharapp/bloc/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewRepo {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addReview(Review review) async {
    await _firestore.runTransaction((transaction) async {
      await _firestore.collection('reviews').add(review.toJson());
    });
  }

  Future<List<QueryDocumentSnapshot>> getReviewByCompanyId(
      String companyId) async {
    return await _firestore
        .collection('reviews')
        .where('companyId', isEqualTo: companyId)
        .limit(10)
        .get(GetOptions(source: Source.serverAndCache))
        .then((value) => value.docs);
  }
}
