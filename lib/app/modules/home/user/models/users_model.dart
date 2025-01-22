class UsersModel {
    UsersModel({
        required this.success,
        required this.message,
        required this.users,
        required this.meta,
    });

    final bool success;
    final String message;
    final List<User> users;
    final Meta? meta;

    UsersModel copyWith({
        bool? success,
        String? message,
        List<User>? users,
        Meta? meta,
    }) {
        return UsersModel(
            success: success ?? this.success,
            message: message ?? this.message,
            users: users ?? this.users,
            meta: meta ?? this.meta,
        );
    }

    factory UsersModel.fromJson(Map<String, dynamic> json){ 
        return UsersModel(
            success: json["success"] ?? false,
            message: json["message"] ?? "",
            users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "users": users.map((x) => x?.toJson()).toList(),
        "meta": meta?.toJson(),
    };

}

class Meta {
    Meta({
        required this.total,
        required this.currentPage,
        required this.perPage,
        required this.lastPage,
    });

    final num total;
    final num currentPage;
    final num perPage;
    final num lastPage;

    Meta copyWith({
        num? total,
        num? currentPage,
        num? perPage,
        num? lastPage,
    }) {
        return Meta(
            total: total ?? this.total,
            currentPage: currentPage ?? this.currentPage,
            perPage: perPage ?? this.perPage,
            lastPage: lastPage ?? this.lastPage,
        );
    }

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
            total: json["total"] ?? 0,
            currentPage: json["currentPage"] ?? 0,
            perPage: json["perPage"] ?? 0,
            lastPage: json["lastPage"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "total": total,
        "currentPage": currentPage,
        "perPage": perPage,
        "lastPage": lastPage,
    };

}

class User {
    User({
        required this.id,
        required this.name,
        required this.photo,
        required this.phone,
        required this.email,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    final int id;
    final String name;
    final String? photo;
    final String phone;
    final String email;
    final dynamic emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    User copyWith({
        int? id,
        String? name,
        String? photo,
        String? phone,
        String? email,
        dynamic? emailVerifiedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return User(
            id: id ?? this.id,
            name: name ?? this.name,
            photo: photo ?? this.photo,
            phone: phone ?? this.phone,
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
            photo: json["photo"] ?? "",
            phone: json["phone"] ?? "",
            email: json["email"] ?? "",
            emailVerifiedAt: json["email_verified_at"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo ?? null,
        "phone": phone,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

}
