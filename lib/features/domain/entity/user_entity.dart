// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserEntity {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatar: json['avatar'] as String,
    );
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatar: $avatar)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] as int,
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory UserEntity.fromJson(String source) => UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
