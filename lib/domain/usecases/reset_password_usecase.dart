import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase
    extends UseCase<DataState<ResetPasswordModel>, LoginParams> {
  AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<DataState<ResetPasswordModel>> call(LoginParams params) async {
    return await repository.resetPassword(params);
  }
}
