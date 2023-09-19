import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/write_local_storage_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/refresh_token_model.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
import 'package:easy_lamp/domain/usecases/refresh_token_usecase.dart';
import 'package:easy_lamp/domain/usecases/write_localstorage_usecase.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  ReadLocalStorageUseCase readLocalStorageUseCase;
  WriteLocalStorageUseCase writeLocalStorageUseCase;
  RefreshTokenUseCase refreshTokenUseCase;

  SplashBloc(
    this.readLocalStorageUseCase,
    this.writeLocalStorageUseCase,
    this.refreshTokenUseCase,
  ) : super(SplashState(
          checkLoginStatus: BaseNoAction(),
          refreshTokenStatus: BaseNoAction(),
        )) {
    on<CheckLoginEvent>((event, emit) async {
      DataState dataState = await readLocalStorageUseCase(Constants.accessKey);
      emit(state.copyWith(
          newCheckLoginStatus: BaseSuccess(dataState is DataSuccess &&
              dataState.data.toString().isNotEmpty)));
      if (dataState.data.toString().isNotEmpty) {
        add(RefreshTokenEvent());
      }
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
