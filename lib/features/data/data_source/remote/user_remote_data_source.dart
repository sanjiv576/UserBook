import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:http/http.dart' as http;
import '../../../../core/failure/failure.dart';
import '../../../domain/entity/user_entity.dart';
import '../../../../config/constants/api_endpoints.dart';

@immutable
class UserRemoteDataSource {
  const UserRemoteDataSource._();

  static Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final res = await http.get(Uri.parse(ApiEndpoints.getUsers));

      if (res.statusCode == 200) {
        final decodedData = jsonDecode(res.body)['data'];

        List<UserEntity> users =
            (decodedData as dynamic)
                .map<UserEntity>((json) => UserEntity.fromJson(json))
                .toList();

        return Right(users);
      }

      return Left(Failure(error: 'Failed to load users'));
    } catch (err) {
      log('Error while fetching: $err');
      return Left(Failure(error: err.toString()));
    }
  }
}
