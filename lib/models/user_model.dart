// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String sessionID;
  final String uid;
  final String email;

  UserModel({
    required this.sessionID,
    required this.uid,
    required this.email,
  });

  UserModel copyWith({
    String? sessionID,
    String? uid,
    String? email,
  }) {
    return UserModel(
      sessionID: sessionID ?? this.sessionID,
      uid: uid ?? this.uid,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sessionID': sessionID,
      'uid': uid,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      sessionID: map['sessionID'] as String,
      uid: map['uid'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
