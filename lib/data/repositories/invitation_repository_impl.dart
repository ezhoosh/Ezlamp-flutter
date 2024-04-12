import 'package:easy_lamp/core/network/i_api_request_manager.dart';
import 'package:easy_lamp/core/repository/base_repository.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/create_invitation_params.dart';
import 'package:easy_lamp/core/params/get_invitation_list_params.dart';
import 'package:easy_lamp/core/params/patch_invitation_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/invitation_model.dart';
import 'package:easy_lamp/domain/repositories/invitation_repository.dart';

class InvitationRepositoryImpl extends BaseRepository implements InvitationRepository {
  InvitationRepositoryImpl(IHttpClient httpClient) : super(httpClient);

  @override
  Future<DataState<String>> acceptInvite(int id) async {
    try {
      var response = await  httpClient.postRequest(path:
      "invitations/$id/accept/",
      );
      // if (response.statusCode == 200) {
        return DataSuccess(response.toString());
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<String>> removeUserFromAllLamp(String id) async {
    try {
      var response = await  httpClient.deleteRequest(path:
      "invitations/remove_user_from_all_lamps/$id/",
      );
      // if (response.statusCode == 200) {
        return DataSuccess(response.toString());
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<String>> declineInvite(int id) async {
    try {
      var response = await  httpClient.postRequest(path:
      "invitations/$id/decline/",
      );
      // if (response.statusCode == 200) {
        return DataSuccess(response.toString());
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<List<InvitationModel>>> getInvitationList(
      GetInvitationListParams params) async {
    try {
      var response = await  httpClient.getRequest(path:
      "invitations/",
        queryParameters: {
          if (params.groupLamp != null) 'group_lamp': params.groupLamp,
          if (params.phoneNumber != null) 'phone_number': params.phoneNumber,
        },
      );
      // if (response.statusCode == 200) {
        return DataSuccess(List<InvitationModel>.from(
            response.map((model) => InvitationModel.fromJson(model))));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      print(e.error);
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<List<InvitationModel>>>
      getMyInvitationAssignmentList() async {
    try {
      var response = await  httpClient.getRequest(path:
      "invitations/my-invite-assignments/",
      );
      // if (response.statusCode == 200) {
        return DataSuccess(List<InvitationModel>.from(
            response.map((model) => InvitationModel.fromJson(model))));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      print(e.error);
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<String>> createInvitation(
      CreateInvitationParams params) async {
    try {
      var response = await  httpClient.postRequest(path:
      "invitations/",
        data: {
          'group_lamp': params.groupLamp,
          'phone_number': params.phoneNumber,
          // 'assignee': params.assignee,
          'message': params.message,
          'lamps': params.lamps,
        },
      );
      // if (response.statusCode == 201) {
        return DataSuccess(response.toString());
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<String>> deleteInvitationGetById(int id) async {
    try {
      var response = await  httpClient.deleteRequest(path:
      "invitations/$id/",
        data: {},
      );
      // if (response.statusCode == 204) {
        return DataSuccess(response.toString());
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<InvitationModel>> getInvitationGetById(int id) async {
    try {
      var response = await  httpClient.getRequest(path:
      "invitations/$id/",
      );
      // if (response.statusCode == 200) {
        return DataSuccess(InvitationModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<InvitationModel>> getInvitationGroupGetById(
      int groupId) async {
    try {
      var response = await  httpClient.getRequest(path:
      "invitations/group/$groupId/",
      );
      // if (response.statusCode == 200) {
        return DataSuccess(InvitationModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<InvitationModel>> patchInvitation(
      UpdateInvitationParams params) async {
    try {
      var response = await  httpClient.patchRequest(path:
      "invitations/${params.id}/",
        data: {
          if (params.lamps != null) 'lamps': jsonEncode(params.lamps),
          if (params.groupLamp != null) 'group_lamp': params.groupLamp,
          if (params.assignee != null) 'assignee': params.assignee,
          if (params.message != null) 'message': params.message,
          if (params.phoneNumber != null) 'phone_number': params.phoneNumber,
        },
      );
      // if (response.statusCode == 200) {
        return DataSuccess(response);
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<InvitationModel>> putInvitation(
      UpdateInvitationParams params) async {
    try {
      var response = await  httpClient.putRequest(path:
      "invitations/${params.id}/",
        data: {
          'lamps': jsonEncode(params.lamps),
          'group_lamp': params.groupLamp,
          'assignee': params.assignee,
          'message': params.message,
          'phone_number': params.phoneNumber,
        },
      );
      // if (response.statusCode == 200) {
        return DataSuccess(response);
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
}
