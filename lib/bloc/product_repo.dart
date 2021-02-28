import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> getAllProductsByCompanyId(
      String id) async {
    Query query =
        _firestore.collection("product").where('companyId', isEqualTo: id);
    return query
        .get(GetOptions(source: Source.serverAndCache))
        .then((value) => value.docs);
  }

  Future<List<QueryDocumentSnapshot>> getProduct(String productId) async {
    return await _firestore
        .collection('product')
        .where('image', isEqualTo: productId)
        .get(GetOptions(source: Source.serverAndCache))
        .then((value) => value.docs);
  }

  Future<List<QueryDocumentSnapshot>> getProductByKeyword(
      String keyword, int limit) async {
    return await _firestore
        .collection('product')
        .where("firstCountry", isEqualTo: "India")
        .where("manufacture", isEqualTo: keyword)
        .limit(limit)
        .get(GetOptions(source: Source.serverAndCache))
        .then((value) => value.docs);
  }
}
