
class OwnerModel {
    String phoneNumber;
    String firstName;
    String lastName;
    String email;

    OwnerModel({
        required this.phoneNumber,
        required this.firstName,
        required this.lastName,
        required this.email,
    });

    factory OwnerModel.fromJson(Map<String, dynamic> json) => OwnerModel(
        phoneNumber: json["phone_number"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
    };
}