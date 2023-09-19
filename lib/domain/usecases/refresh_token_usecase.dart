import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/refresh_token_model.dart';
import 'package:easy_lamp/domain/repositories/splash_repository.dart';

class RefreshTokenUseCase extends UseCase<DataState<RefreshTokenModel>, String> {
  SplashRepository repository;

  RefreshTokenUseCase(this.repository);

  @override
  Future<DataState<RefreshTokenModel>> call(String params) async {
    return await repository.refreshToken(params);
  }
}
