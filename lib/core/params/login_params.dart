class LoginParams {
  String number;
  String? password;
  String? smsToken;

  LoginParams(this.number, {this.smsToken, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone_number'] = number;
    if (password != null) {
      if (password!.isNotEmpty) {
        data['password'] = password;
      }
    }
    if (smsToken != null) {
      if (smsToken!.isNotEmpty) {
        data['sms_token'] = smsToken;
      }
    }
    return data;
  }
}
