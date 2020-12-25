import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CommanGetCalls {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseStorage storageRef = FirebaseStorage.instance;

  Future<DocumentReference> addCompany(Map<String, Object> company) async {
    return _firestore.collection("company").add(company);
  }

  getImage(String fileName) async {
    return await storageRef.ref().child(fileName).getDownloadURL();
  }

  Future<QuerySnapshot> getAboutUs() async {
    Query query = _firestore.collection("aboutUs");
    return query.get(GetOptions(source: Source.serverAndCache));
  }

  Future<QuerySnapshot> getPrivacy() async {
    Query query = _firestore.collection("privacy");
    return query.get(GetOptions(source: Source.serverAndCache));
  }

  Future<QuerySnapshot> getFaq() async {
    Query query = _firestore.collection("faq");
    return query.get(GetOptions(source: Source.serverAndCache));
  }
}
