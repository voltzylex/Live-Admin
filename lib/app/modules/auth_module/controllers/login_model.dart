import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
    const LoginModel({
        required this.success,
        required this.message,
        required this.admin,
        required this.accessToken,
    });

    final bool success;
    final String message;
    final Admin? admin;
    final String accessToken;

    LoginModel copyWith({
        bool? success,
        String? message,
        Admin? admin,
        String? accessToken,
    }) {
        return LoginModel(
            success: success ?? this.success,
            message: message ?? this.message,
            admin: admin ?? this.admin,
            accessToken: accessToken ?? this.accessToken,
        );
    }

    factory LoginModel.fromJson(Map<String, dynamic> json){ 
        return LoginModel(
            success: json["success"] ?? false,
            message: json["message"] ?? "",
            admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
            accessToken: json["access_token"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "admin": admin?.toJson(),
        "access_token": accessToken,
    };

    @override
    List<Object?> get props => [
    success, message, admin, accessToken, ];
}

class Admin extends Equatable {
    const Admin({
        required this.id,
        required this.name,
        required this.email,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    final int id;
    final String name;
    final String email;
    final dynamic emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Admin copyWith({
        int? id,
        String? name,
        String? email,
        dynamic emailVerifiedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return Admin(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory Admin.fromJson(Map<String, dynamic> json){ 
        return Admin(
            id: json["id"] ?? 0,
            name: json["name"] ?? "",
            email: json["email"] ?? "",
            emailVerifiedAt: json["email_verified_at"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

    @override
    List<Object?> get props => [
    id, name, email, emailVerifiedAt, createdAt, updatedAt, ];
}
