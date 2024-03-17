import 'package:dio/dio.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorHelper {
  static String getCatchError(DioError error) {
    return error.response == null
        ? "ERROR"
        : error.response!.statusCode.toString();
  }

  static String getError(Response error) {
    return error.statusCode.toString();
  }

  static void getBaseError(BaseStatus error, BuildContext context) {
    EasyLoading.showError(ErrorHelper.getErrorMessage(error, context));
  }

  static String getErrorMessage(BaseStatus error, BuildContext context) {
    String errorStr = (error as BaseError).error ?? '';
    String a = '';

    switch (errorStr) {
      case "ERROR":
        a = AppLocalizations.of(context)!.error;
        break;
      case "400":
        a = AppLocalizations.of(context)!.error400;
        break;
      case "401":
        BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
        a = AppLocalizations.of(context)!.error401;
        break;
      case "403":
        a = AppLocalizations.of(context)!.error403;
        break;
      case "404":
        a = AppLocalizations.of(context)!.error404;
        break;
      case "405":
        a = AppLocalizations.of(context)!.error405;
        break;
      case "500":
        a = AppLocalizations.of(context)!.error500;
        break;
      case "409":
        a = AppLocalizations.of(context)!.error409;
        break;
      case "422":
        a = AppLocalizations.of(context)!.error422;
        break;
      case "202":
        a = AppLocalizations.of(context)!.error202;
        break;
      case "408":
        a = AppLocalizations.of(context)!.error408;
        break;
      case "429":
        a = AppLocalizations.of(context)!.error429;
        break;
    }
    return a;
  }
}
