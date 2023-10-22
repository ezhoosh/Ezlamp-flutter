class CreateInvitationParams {
  String phoneNumber;
  String message;
  int groupLamp;
  List<int> lamps;

  CreateInvitationParams({
    required this.phoneNumber,
    required this.message,
    required this.groupLamp,
    required this.lamps,
  });
}
