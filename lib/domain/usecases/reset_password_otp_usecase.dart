import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class ResetPasswordOtpUseCase
    extends UseCase<DataState<RegisterVerifyModel>, LoginParams> {
  AuthRepository repository;

  ResetPasswordOtpUseCase(this.repository);

  @override
  Future<DataState<RegisterVerifyModel>> call(LoginParams param) async {
    return await repository.resetPasswordOtp(param);
  }
}
