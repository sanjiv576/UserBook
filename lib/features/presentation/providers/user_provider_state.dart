import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/failure/failure.dart';
import '../../data/data_source/remote/user_remote_data_source.dart';
import '../../domain/entity/user_entity.dart';
import '../state/user_state.dart';

final userProvider =
    StateNotifierProvider.autoDispose<UserProviderState, UserState>(
      (ref) => UserProviderState(),
    );

class UserProviderState extends StateNotifier<UserState> {
  UserProviderState() : super(UserState.initial());

  Future<void> getUserById(int userId) async {
    state = state.copyWith(isLoading: true);

    final res = await UserRemoteDataSource.getUserById(userId);
    res.fold(
      (error) {
        state = state.copyWith(error: error.error.toString(), isLoading: false);
      },
      (user) {
        state = state.copyWith(user: user, isLoading: false);
      },
    );
  }

  Future<void> updateUserById({required UserEntity updatedUser}) async {
    state = state.copyWith(isLoading: true);

    final res = await UserRemoteDataSource.updateUserById(
      id: updatedUser.id,
      firstName: updatedUser.firstName,
      lastName: updatedUser.lastName,
      email: updatedUser.email,
      avatar: updatedUser.avatar,
    );
    res.fold(
      (error) {
        state = state.copyWith(error: error.error.toString(), isLoading: false);
      },
      (user) {
        state = state.copyWith(user: user, isLoading: false);
      },
    );
  }

  Future<Either<Failure, bool>> deleteUserById({required int userId}) async {
    state = state.copyWith(isLoading: true);

    final res = await UserRemoteDataSource.deleteUserById(userId);

    res.fold(
      (error) {
        state = state.copyWith(error: error.error.toString(), isLoading: false);
        return Left(Failure(error: error.toString()));
      },
      (boolValue) {
        state = state.copyWith(user: null, isLoading: false);
        return Right(true);
      },
    );
    return Right(true);
  }
}
