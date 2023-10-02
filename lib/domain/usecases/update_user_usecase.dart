import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/params/user_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/data/model/user_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';
import 'package:easy_lamp/domain/repositories/user_repository.dart';

class UpdateUserUseCase extends UseCase<DataState<UserModel>, UserParams> {
  UserRepository repository;

  UpdateUserUseCase(this.repository);

  @override
  Future<DataState<UserModel>> call(UserParams params) async {
    return await repository.getUser();
  }
}
