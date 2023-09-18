import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class RegisterUseCase extends UseCase<DataState<LoginModel>, LoginParams> {
  AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<DataState<LoginModel>> call(LoginParams params) async {
    return await repository.register(params);
  }
}
