import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/send_login_otp.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class SendLoginOtpUseCase
    extends UseCase<DataState<SendLoginOtpModel>, String> {
  AuthRepository repository;

  SendLoginOtpUseCase(this.repository);

  @override
  Future<DataState<SendLoginOtpModel>> call(String params) async {
    return await repository.sendLoginOtp(params);
  }
}
