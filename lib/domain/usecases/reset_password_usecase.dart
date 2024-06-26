import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/reset_passowrd_response.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase
    extends UseCase<DataState<ResetPasswordResponse>, LoginParams> {
  AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<DataState<ResetPasswordResponse>> call(LoginParams param) async {
    return await repository.resetPassword(param);
  }
}
