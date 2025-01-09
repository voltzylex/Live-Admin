import 'package:equatable/equatable.dart';

class UsersModel extends Equatable {
    UsersModel({
        required this.success,
        required this.message,
        required this.users,
    });

    final bool success;
    final String message;
    final List<User> users;

    UsersModel copyWith({
        bool? success,
        String? message,
        List<User>? users,
    }) {
        return UsersModel(
            success: success ?? this.success,
            message: message ?? this.message,
            users: users ?? this.users,
        );
    }

    factory UsersModel.fromJson(Map<String, dynamic> json){ 
        return UsersModel(
            success: json["success"] ?? false,
            message: json["message"] ?? "",
            users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "users": users.map((x) => x?.toJson()).toList(),
    };

    @override
    List<Object?> get props => [
    success, message, users, ];
}

class User extends Equatable {
    User({
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

    User copyWith({
        int? id,
        String? name,
        String? email,
        dynamic? emailVerifiedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return User(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
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
