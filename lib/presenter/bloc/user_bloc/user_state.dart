part of 'user_bloc.dart';

class UserState {
  BaseStatus getUserStatus, updateUserStatus;
  BaseStatus getVersion;

  UserState({
    required this.getUserStatus,
    required this.updateUserStatus,
    required this.getVersion,
  });

  UserState copyWith({
    BaseStatus? newGetUserStatus,
    newUpdateUserStatus,
    newGetVersion
  }) {
    return UserState(
      getUserStatus: newGetUserStatus ?? getUserStatus,
      updateUserStatus: newUpdateUserStatus ?? updateUserStatus,
      getVersion: newGetVersion ?? getVersion,
    );
  }
}
