import 'package:atamnirbharapp/bloc/company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future addOrUpdateCompany(Company company) async {
    return _firestore.runTransaction((transaction) async {
      _firestore.collection('userAddedCompany').doc().set(company.toJson());
    });
  }

  Future<List<QueryDocumentSnapshot>> getCompany(String companyId) async {
    return await _firestore
        .collection('company')
        .where('companyId', isEqualTo: companyId)
        .get(GetOptions(source: Source.serverAndCache))
        .then((value) => value.docs);
  }

  Future<List<QueryDocumentSnapshot>> getCompanyBySector(
      String sector, int limit) async {
    return await _firestore
        .collection('company')
        .where('sector', isEqualTo: sector)
        .where('firstCountry', isEqualTo: 'India')
        .limit(limit)
        .get(GetOptions(source: Source.serverAndCache))
        .then((value) => value.docs);
  }

  Future<QuerySnapshot> getAllCompany() async {
    Query query = _firestore.collection("company");
    return query.get(GetOptions(source: Source.cache)).then((value) =>
        value.docs.length == 0
            ? query
                .get(GetOptions(source: Source.serverAndCache))
                .then((value) => value)
            : value);
  }

  void updateRatingCompany(String id, String rating) async {
    DocumentReference query = _firestore.collection("company").doc(id);
    await _firestore.runTransaction((transaction) async {
      transaction.set(query, {"ratings": rating}, SetOptions(merge: true));
    });
  }
}
