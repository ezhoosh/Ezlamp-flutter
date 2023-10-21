class CreateInvitationParams {
  String phoneNumber;
  String message;
  int assignee;
  int groupLamp;
  List<int> lamps;

  CreateInvitationParams({
    required this.phoneNumber,
    required this.message,
    required this.assignee,
    required this.groupLamp,
    required this.lamps,
  });
}
