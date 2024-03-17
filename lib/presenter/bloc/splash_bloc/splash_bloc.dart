import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/write_local_storage_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/data/model/refresh_token_model.dart';
import 'package:easy_lamp/domain/usecases/read_connection_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
import 'package:easy_lamp/domain/usecases/refresh_token_usecase.dart';
import 'package:easy_lamp/domain/usecases/write_localstorage_usecase.dart';
import 'package:easy_lamp/presenter/bloc/splash_bloc/splash_status.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  ReadLocalStorageUseCase readLocalStorageUseCase;
  WriteLocalStorageUseCase writeLocalStorageUseCase;
  RefreshTokenUseCase refreshTokenUseCase;
  ReadConnectionUseCase readConnectionUseCase;

  SplashBloc(
    this.readLocalStorageUseCase,
    this.writeLocalStorageUseCase,
    this.refreshTokenUseCase,
    this.readConnectionUseCase,
  ) : super(SplashState(
          checkLoginStatus: SplashNoAction(),
          refreshTokenStatus: BaseNoAction(),
        )) {
    on<CheckLoginEvent>((event, emit) async {
      DataState dataState = await readLocalStorageUseCase(Constants.accessKey);
      ConnectionType type = await readConnectionUseCase(NoParams());
      if (type == ConnectionType.Bluetooth) {
        emit(state.copyWith(
            newCheckLoginStatus: SplashSuccessWithBlue(
                dataState is DataSuccess &&
                    dataState.data.toString().isNotEmpty)));
      } else {
        emit(state.copyWith(newCheckLoginStatus: SplashLoading()));
        try {
          DataState refreshDataState =
              await readLocalStorageUseCase(Constants.refreshKey);
          DataState accessDataState =
              await readLocalStorageUseCase(Constants.accessKey);
          print('refresh token: ${refreshDataState.data.toString()}');
          print('before access token: ${accessDataState.data.toString()}');
          if (refreshDataState.data.toString().isNotEmpty) {
            DataState dataState =
                await refreshTokenUseCase(refreshDataState.data);
            if (dataState is DataSuccess) {
              RefreshTokenModel model = dataState.data;
              print('access token: ${model.access}');
              await writeLocalStorageUseCase(
                  WriteLocalStorageParam(Constants.accessKey, model.access));

              emit(state.copyWith(
                  newCheckLoginStatus: SplashSuccessWithOutBlue(
                      dataState.data.toString().isNotEmpty)));
            } else {
              emit(state.copyWith(
                  newCheckLoginStatus: SplashError(dataState.error)));
            }
          } else {
            emit(state.copyWith(newCheckLoginStatus: SplashNewUser()));
          }
        } catch (e) {
          emit(state.copyWith(newCheckLoginStatus: SplashError(e.toString())));
        }
      }
      // if (dataState.data.toString().isNotEmpty) {
      //   add(RefreshTokenEvent());
      // }
    });
    on<RefreshTokenEvent>((event, emit) async {
      emit(state.copyWith(newRefreshTokenStatus: BaseLoading()));
      try {
        DataState refreshDataState =
            await readLocalStorageUseCase(Constants.refreshKey);
        DataState dataState = await refreshTokenUseCase(refreshDataState.data);
        if (dataState is DataSuccess) {
          RefreshTokenModel model = dataState.data;
          await writeLocalStorageUseCase(
              WriteLocalStorageParam(Constants.accessKey, model.access));
          emit(state.copyWith(newRefreshTokenStatus: BaseSuccess(null)));
        } else {
          emit(state.copyWith(
              newRefreshTokenStatus: BaseError(dataState.error)));
        }
      } catch (e) {
        emit(state.copyWith(newRefreshTokenStatus: BaseError(e.toString())));
      }
      emit(state.copyWith(newRefreshTokenStatus: BaseNoAction()));
    });
  }
}
