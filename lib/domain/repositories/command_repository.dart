import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/command_params.dart';
import 'package:easy_lamp/core/params/register_verify_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/params/send_phone_number_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/data/model/command_model.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/data/model/send_login_otp.dart';
import 'package:easy_lamp/data/model/send_number_model.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/change_password_page.dart';

abstract class CommandRepository {
  Future<DataState<CommandModel>> sendCommand(CommandParams params);
}
