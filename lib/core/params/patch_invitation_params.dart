class UpdateInvitationParams {
  int? id;
  String? phoneNumber;
  String? message;
  int? assignee;
  int? groupLamp;
  List<int>? lamps;

  UpdateInvitationParams({
    required this.id,
    required this.phoneNumber,
    required this.message,
    required this.assignee,
    required this.groupLamp,
    required this.lamps,
  });
}
