import 'package:atamnirbharapp/bloc/user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future addOrUpdateUser(UserDetails user) {
    return _firestore.runTransaction((transaction) async {
      _firestore.collection('userDetails').doc(user.uid).set(user.toJson());
    });
  }

  Future<DocumentSnapshot> getUserById(docId) async {
    return await _firestore
        .collection('userDetails')
        .doc(docId)
        .get(GetOptions(source: Source.serverAndCache));
  }
}
