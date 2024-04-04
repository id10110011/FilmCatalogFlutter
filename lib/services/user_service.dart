import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../utils/user_converter.dart';

class UserService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");

  Future<bool> saveUser(User user) {
    return _usersCollection.doc(user.email).set(UserConverter.userToJSON(user))
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<User> getUser(String? email) async {
    DocumentSnapshot<Object?> res = await _usersCollection.doc(email).get();
    return UserConverter.userFromSnapshot(res);
  }

  Future<bool> deleteUser(String? email) async {
    return _usersCollection.doc(email).delete()
      .then((value) => true);
  }
}
