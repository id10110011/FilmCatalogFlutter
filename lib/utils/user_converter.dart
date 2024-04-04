import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserConverter {
  static User userFromSnapshot(DocumentSnapshot<Object?> snapshot) {
    return User(
      snapshot["email"],
      snapshot["firstname"],
      snapshot["lastname"],
      snapshot["dateOfBirth"],
      snapshot["country"],
      snapshot["city"],
      snapshot["gender"],
      snapshot["education"],
      snapshot["description"],
    );
  }

  static Map<String, dynamic> userToJSON(User user) {
    return {
      "email": user.email,
      "firstname": user.firstname,
      "lastname": user.lastname,
      "dateOfBirth": user.dateOfBirth,
      "country": user.county,
      "city": user.city,
      "gender": user.gender,
      "education": user.education,
      "description": user.description
    };
  }
}