import '../../domain/entity/user_entity.dart';

class UserState {
  final bool isLoading;
  final String? error;
  final UserEntity? user;

  UserState({required this.isLoading, this.error, this.user});

  factory UserState.initial() {
    return UserState(isLoading: false, error: null, user: null);
  }

  UserState copyWith({bool? isLoading, String? error, UserEntity? user}) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}
