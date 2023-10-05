import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class ChangePasswordUseCase
    extends UseCase<DataState<String>, ChangePasswordParams> {
  AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  Future<DataState<String>> call(ChangePasswordParams params) async {
    return await repository.changePassword(params);
  }
}
