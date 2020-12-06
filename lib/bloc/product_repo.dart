import 'package:atamnirbharapp/bloc/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> getAllProductsByCompanyId(
      String id) async {
    Query query =
        _firestore.collection("product").where('companyId', isEqualTo: id);
    return query.get(GetOptions(source: Source.cache)).then((value) =>
        value.docs.length == 0
            ? query
                .get(GetOptions(source: Source.serverAndCache))
                .then((value) => value.docs)
            : value.docs);
  }

  Future<List<QueryDocumentSnapshot>> getProduct(String productId) async {
    return await _firestore
        .collection('product')
        .where('image', isEqualTo: productId)
        .get(GetOptions(source: Source.serverAndCache))
        .then((value) => value.docs);
  }

  Future<List<QueryDocumentSnapshot>> getProductByKeyword(
      String keyword) async {
    return await _firestore
        .collection('product')
        .where("firstCountry", isEqualTo: "India")
        .where("manufacture", isEqualTo: keyword)
        .limit(3)
        .get(GetOptions(source: Source.serverAndCache))
        .then((value) => value.docs);
  }
}
