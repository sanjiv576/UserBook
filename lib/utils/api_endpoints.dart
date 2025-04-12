import 'package:flutter/foundation.dart' show immutable;

@immutable
class ApiEndpoints {
  static const String getUsers = 'https://reqres.in/api/users';
  static const String createUser = 'https://reqres.in/api/users/';
  static const String updateUserById = 'https://reqres.in/api/users/';
  static const String deleteUserById = 'https://reqres.in/api/users/';
  static const String getSingleUserById = 'https://reqres.in/api/users/';
  const ApiEndpoints._();
}
