import 'package:atamnirbharapp/bloc/company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStore {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference> addCompany(Map<String, Object> company) async {
    return _firestore.collection("company").add(company);
  }

  Future<Company> getCompany(String name) async {
    await _firestore.collection("company").where("name", isEqualTo: name);
  }
}
