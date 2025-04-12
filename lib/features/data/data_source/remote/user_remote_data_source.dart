import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:http/http.dart' as http;

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../domain/entity/user_entity.dart';

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

  static Future<Either<Failure, UserEntity>> getUserById(int id) async {
    try {
      final res = await http.get(
        Uri.parse('${ApiEndpoints.getSingleUserById}/$id'),
      );

      if (res.statusCode == 200) {
        final decodedData = jsonDecode(res.body)['data'];

        UserEntity user = UserEntity.fromJson(decodedData);

        log("Single user: $user");

        return Right(user);
      }

      return Left(Failure(error: 'Failed to load users'));
    } catch (err) {
      log('Error while fetching: $err');
      return Left(Failure(error: err.toString()));
    }
  }

  static Future<Either<Failure, UserEntity>> updateUserById({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required String avatar,
  }) async {
    try {
      final response = await http
          .put(
            Uri.parse('${ApiEndpoints.updateUserById}/$id'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'first_name': firstName,
              'last_name': lastName,
              'email': email,
            }),
          )
          .timeout(const Duration(seconds: 10));

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return Right(
          UserEntity.fromJson({...json, 'id': id, 'avatar': avatar}),
        );
      }
      return Left(Failure(error: 'Failed to update: ${response.statusCode}'));
    } on TimeoutException {
      return Left(Failure(error: 'Request timed out'));
    } catch (e) {
      return Left(Failure(error: 'Failed to update: ${e.toString()}'));
    }
  }

  static Future<Either<Failure, bool>> deleteUserById(int id) async {
    try {
      final response = await http
          .delete(
            Uri.parse('${ApiEndpoints.deleteUserById}/$id'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(true); // Successfully deleted
      }

      return Left(
        Failure(
          error: 'Failed to delete user (Status: ${response.statusCode})',
        ),
      );
    } on TimeoutException {
      return Left(Failure(error: 'Request timed out'));
    } on http.ClientException catch (e) {
      return Left(Failure(error: 'Network error: ${e.message}'));
    } catch (e) {
      return Left(Failure(error: 'Unexpected error: ${e.toString()}'));
    }
  }
}
