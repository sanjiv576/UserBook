import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart' show immutable;
import 'package:http/http.dart' as http;
import 'package:usersbook/model/user_entity.dart';
import 'package:usersbook/utils/api_endpoints.dart';

@immutable
class RemoteDataSource {
  const RemoteDataSource._();

  static Future<void> getAllUsers() async {
    try {
      final res = await http.get(Uri.parse(ApiEndpoints.getUsers));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body)['data'];

        log('d: $data');


        final users = data.map(Map<>)
        log('Data: $users');
      }
    } catch (err) {
      log('Error while fetching: $err');
    }
  }
}
