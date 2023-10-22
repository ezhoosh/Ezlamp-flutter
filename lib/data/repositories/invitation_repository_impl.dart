import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/create_invitation_params.dart';
import 'package:easy_lamp/core/params/get_invitation_list_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/params/patch_invitation_params.dart';
import 'package:easy_lamp/core/params/register_verify_params.dart';
import 'package:easy_lamp/core/params/send_phone_number_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/data/model/invitation_model.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/data/model/send_login_otp.dart';
import 'package:easy_lamp/data/model/send_number_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';
import 'package:easy_lamp/domain/repositories/invitation_repository.dart';

class InvitationRepositoryImpl extends InvitationRepository {
  @override
  Future<DataState<String>> acceptInvite(int id) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "invitations/$id/accept/",
        method: 'POST',
      );
      if (response.statusCode == 200) {
        return DataSuccess(response.data.toString());
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<String>> declineInvite(int id) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "invitations/$id/decline/",
        method: 'POST',
      );
      if (response.statusCode == 200) {
        return DataSuccess(response.data.toString());
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<List<InvitationModel>>> getInvitationList(
      GetInvitationListParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "invitations/",
        data: {
          if (params.groupLamp != null) 'group_lamp': params.groupLamp,
          if (params.phoneNumber != null) 'phone_number': params.phoneNumber,
        },
        method: 'GET',
      );
      if (response.statusCode == 200) {
        return DataSuccess(List<InvitationModel>.from(
            response.data.map((model) => InvitationModel.fromJson(model))));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<List<InvitationModel>>>
      getMyInvitationAssignmentList() async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "invitations/my-invite-assignments/",
        method: 'GET',
      );
      if (response.statusCode == 200) {
        return DataSuccess(List<InvitationModel>.from(
            response.data.map((model) => InvitationModel.fromJson(model))));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<InvitationModel>> createInvitation(
      CreateInvitationParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "invitations/",
        data: {
          'group_lamp': params.groupLamp,
          'phone_number': params.phoneNumber,
          // 'assignee': params.assignee,
          'message': params.message,
          'lamps': params.lamps,
        },
        method: 'POST',
      );
      if (response.statusCode == 201) {
        return DataSuccess(InvitationModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<String>> deleteInvitationGetById(int id) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "invitations/$id/",
        data: {},
        method: 'DELETE',
      );
      if (response.statusCode == 204) {
        return DataSuccess(response.data.toString());
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<InvitationModel>> getInvitationGetById(int id) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "invitations/$id/",
        method: 'GET',
      );
      if (response.statusCode == 200) {
        return DataSuccess(InvitationModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<InvitationModel>> getInvitationGroupGetById(
      int groupId) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "invitations/group/$groupId/",
        method: 'GET',
      );
      if (response.statusCode == 200) {
        return DataSuccess(InvitationModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<InvitationModel>> patchInvitation(
      UpdateInvitationParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "invitations/${params.id}/",
        data: {
          if (params.lamps != null) 'lamps': jsonEncode(params.lamps),
          if (params.groupLamp != null) 'group_lamp': params.groupLamp,
          if (params.assignee != null) 'assignee': params.assignee,
          if (params.message != null) 'message': params.message,
          if (params.phoneNumber != null) 'phone_number': params.phoneNumber,
        },
        method: 'PATCH',
      );
      if (response.statusCode == 200) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<InvitationModel>> putInvitation(
      UpdateInvitationParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "invitations/${params.id}/",
        data: {
          'lamps': jsonEncode(params.lamps),
          'group_lamp': params.groupLamp,
          'assignee': params.assignee,
          'message': params.message,
          'phone_number': params.phoneNumber,
        },
        method: 'PUT',
      );
      if (response.statusCode == 200) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
