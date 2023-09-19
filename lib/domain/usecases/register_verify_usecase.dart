import 'package:easy_lamp/core/params/register_verify_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class RegisterVerifyUseCase
    extends UseCase<DataState<RegisterVerifyModel>, RegisterVerifyParams> {
  AuthRepository repository;

  RegisterVerifyUseCase(this.repository);

  @override
  Future<DataState<RegisterVerifyModel>> call(RegisterVerifyParams params) async {
    return await repository.registerVerify(params);
  }
}
