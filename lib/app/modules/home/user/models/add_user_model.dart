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
  final String? email; // Make nullable
  final String password;
  final String passwordConfirmation;
  final String? photo; // Make nullable
  final int? phone; // Already nullable

  AddUser copyWith({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? photo,
    int? phone, // Renamed for consistency
  }) {
    return AddUser(
      name: name ?? this.name,
      email: email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      photo: photo ?? this.photo,
      phone: phone ?? this.phone,
    );
  }

  factory AddUser.fromJson(Map<String, dynamic> json) {
    return AddUser(
      name: json["name"] ?? "",
      email: json["email"],
      password: json["password"] ?? "",
      passwordConfirmation: json["password_confirmation"] ?? "",
      photo: json["photo"], // Matches nullable type
      phone: json["phone"], // Matches nullable type
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
