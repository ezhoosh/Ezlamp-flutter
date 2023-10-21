import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/create_invitation_params.dart';
import 'package:easy_lamp/core/params/get_invitation_list_params.dart';
import 'package:easy_lamp/core/params/patch_invitation_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/domain/usecases/accept_invite_usecase.dart';
import 'package:easy_lamp/domain/usecases/create_invitation_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/decline_invite_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_invitation_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_invitation_by_group_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_invitation_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_invitation_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_my_invitation_assignment_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/patch_invitation_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/put_invitation_by_id_usecase.dart';
import 'package:meta/meta.dart';

part 'invitation_event.dart';

part 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  GetInvitationListUseCase getInvitationListUseCase;
  GetMyInvitationAssignmentListUseCase getMyInvitationAssignmentListUseCase;
  GetInvitationByIdUseCase getInvitationByIdUseCase;
  GetInvitationByGroupIdUseCase getInvitationByGroupIdUseCase;
  DeleteInvitationUseCase deleteInvitationUseCase;
  CreateInvitationUseCase createInvitationUseCase;
  PutInvitationUseCase putInvitationUseCase;
  PatchInvitationUseCase patchInvitationUseCase;
  AcceptInviteUseCase acceptInviteUseCase;
  DeclineInviteUseCase declineInviteUseCase;

  InvitationBloc(
    this.declineInviteUseCase,
    this.acceptInviteUseCase,
    this.patchInvitationUseCase,
    this.putInvitationUseCase,
    this.createInvitationUseCase,
    this.deleteInvitationUseCase,
    this.getInvitationByGroupIdUseCase,
    this.getInvitationByIdUseCase,
    this.getMyInvitationAssignmentListUseCase,
    this.getInvitationListUseCase,
  ) : super(InvitationState(
            getInvitationListStatus: BaseNoAction(),
            getMyInvitationAssignmentListStatus: BaseNoAction(),
            getInvitationByIdStatus: BaseNoAction(),
            getInvitationByGroupIdStatus: BaseNoAction(),
            deleteInvitationStatus: BaseNoAction(),
            createInvitationStatus: BaseNoAction(),
            putInvitationStatus: BaseNoAction(),
            patchInvitationStatus: BaseNoAction(),
            acceptInviteStatus: BaseNoAction(),
            declineInviteStatus: BaseNoAction())) {
    on<GetInvitationByGroupIdEvent>((event, emit) async {
      emit(state.copyWith(newGetInvitationByGroupIdStatus: BaseLoading()));
      DataState dataState = await getInvitationByGroupIdUseCase(event.groupId);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetInvitationByGroupIdStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newGetInvitationByGroupIdStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newGetInvitationByGroupIdStatus: BaseNoAction()));
    });
    on<GetInvitationListEvent>((event, emit) async {
      emit(state.copyWith(newGetInvitationListStatus: BaseLoading()));
      DataState dataState = await getInvitationListUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetInvitationListStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newGetInvitationListStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newGetInvitationListStatus: BaseNoAction()));
    });
    on<GetInvitationByIdEvent>((event, emit) async {
      emit(state.copyWith(newGetInvitationByIdStatus: BaseLoading()));
      DataState dataState = await getInvitationByIdUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetInvitationByIdStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newGetInvitationByIdStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newGetInvitationByIdStatus: BaseNoAction()));
    });
    on<DeleteInvitationEvent>((event, emit) async {
      emit(state.copyWith(newDeleteInvitationStatus: BaseLoading()));
      DataState dataState = await deleteInvitationUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newDeleteInvitationStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newDeleteInvitationStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newDeleteInvitationStatus: BaseNoAction()));
    });
    on<CreateInvitationEvent>((event, emit) async {
      emit(state.copyWith(newCreateInvitationStatus: BaseLoading()));
      DataState dataState = await createInvitationUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newCreateInvitationStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newCreateInvitationStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newCreateInvitationStatus: BaseNoAction()));
    });
    on<GetMyInvitationAssignmentListEvent>((event, emit) async {
      emit(state.copyWith(
          newGetMyInvitationAssignmentListStatus: BaseLoading()));
      DataState dataState =
          await getMyInvitationAssignmentListUseCase(NoParams());
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetMyInvitationAssignmentListStatus:
                BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newGetMyInvitationAssignmentListStatus:
                BaseError(dataState.error)));
      }
      emit(state.copyWith(
          newGetMyInvitationAssignmentListStatus: BaseNoAction()));
    });
    on<AcceptInviteEvent>((event, emit) async {
      emit(state.copyWith(newAcceptInviteStatus: BaseLoading()));
      DataState dataState = await acceptInviteUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newAcceptInviteStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newAcceptInviteStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newAcceptInviteStatus: BaseNoAction()));
    });
    on<DeclineInviteEvent>((event, emit) async {
      emit(state.copyWith(newDeclineInviteStatus: BaseLoading()));
      DataState dataState = await declineInviteUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newDeclineInviteStatus: BaseSuccess(dataState.data)));
      } else {
        emit(
            state.copyWith(newDeclineInviteStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newDeclineInviteStatus: BaseNoAction()));
    });
  }
}
