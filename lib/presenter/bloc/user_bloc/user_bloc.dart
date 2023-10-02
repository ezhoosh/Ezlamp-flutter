import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/user_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/domain/usecases/get_user_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_user_usecase.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  GetUserUseCase getUserUseCase;
  UpdateUserUseCase updateUserUseCase;

  UserBloc(
    this.getUserUseCase,
    this.updateUserUseCase,
  ) : super(
          UserState(
            getUserStatus: BaseNoAction(),
            updateUserStatus: BaseNoAction(),
          ),
        ) {
    on<UpdateUserEvent>((event, emit) async {
      emit(state.copyWith(newUpdateUserStatus: BaseLoading()));
      DataState dataState = await updateUserUseCase(UserParams(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
      ));
      if (dataState is DataSuccess) {
        emit(state.copyWith(newUpdateUserStatus: BaseSuccess(dataState.data)));
        add(GetUserEvent());
      } else {
        emit(state.copyWith(newUpdateUserStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newUpdateUserStatus: BaseNoAction()));
    });
    on<GetUserEvent>((event, emit) async {
      emit(state.copyWith(newGetUserStatus: BaseLoading()));
      DataState dataState = await getUserUseCase(NoParams());
      if (dataState is DataSuccess) {
        emit(state.copyWith(newGetUserStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newGetUserStatus: BaseError(dataState.error)));
      }

      emit(state.copyWith(newGetUserStatus: BaseNoAction()));
    });
  }
}
