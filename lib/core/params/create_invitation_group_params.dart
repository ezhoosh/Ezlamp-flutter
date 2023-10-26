class CreateInvitationGroupParams {
  String phoneNumber;
  String message;
  Map<int, List<int>> lamps;

  CreateInvitationGroupParams({
    required this.phoneNumber,
    required this.message,
    required this.lamps,
  });
}
