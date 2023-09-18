import 'package:easy_lamp/core/params/send_phone_number_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/send_number_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class SendPhoneNumberUseCase
    extends UseCase<DataState<SendNumberModel>, SendPhoneNumberParams> {
  AuthRepository repository;

  SendPhoneNumberUseCase(this.repository);

  @override
  Future<DataState<SendNumberModel>> call(SendPhoneNumberParams params) async {
    return await repository.sendPhoneNumber(params);
  }
}
