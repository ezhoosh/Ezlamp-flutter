part of 'user_bloc.dart';

class UserState {
  BaseStatus getUserStatus, updateUserStatus;

  UserState({
    required this.getUserStatus,
    required this.updateUserStatus,
  });

  UserState copyWith({
    BaseStatus? newGetUserStatus,
    newUpdateUserStatus,
  }) {
    return UserState(
      getUserStatus: newGetUserStatus ?? getUserStatus,
      updateUserStatus: newUpdateUserStatus ?? updateUserStatus,
    );
  }
}
