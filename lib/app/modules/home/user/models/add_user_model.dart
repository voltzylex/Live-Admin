import 'package:equatable/equatable.dart';

class AddUser extends Equatable {
  const AddUser({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.photo,
    required this.phone,
  });

  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String photo;
  final int? phone;

  AddUser copyWith({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? photo,
    int? mobile,
  }) {
    return AddUser(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      photo: photo ?? this.photo,
      phone: mobile ?? this.phone,
    );
  }

  factory AddUser.fromJson(Map<String, dynamic> json) {
    return AddUser(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      passwordConfirmation: json["password_confirmation"] ?? "",
      photo: json["photo"],
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "photo": photo,
        "phone": phone,
      };

  @override
  List<Object?> get props =>
      [name, email, password, passwordConfirmation, photo, phone];
}
