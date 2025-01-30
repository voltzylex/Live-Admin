import 'package:equatable/equatable.dart';

class MembershipModel extends Equatable {
  const MembershipModel({
    required this.success,
    required this.message,
    required this.myPlans,
    required this.meta,
  });

  final bool success;
  final String message;
  final List<MyPlan> myPlans;
  final Meta? meta;

  MembershipModel copyWith({
    bool? success,
    String? message,
    List<MyPlan>? myPlans,
    Meta? meta,
  }) {
    return MembershipModel(
      success: success ?? this.success,
      message: message ?? this.message,
      myPlans: myPlans ?? this.myPlans,
      meta: meta ?? this.meta,
    );
  }

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      myPlans: json["my_plans"] == null
          ? []
          : List<MyPlan>.from(json["my_plans"]!.map((x) => MyPlan.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "my_plans": myPlans.map((x) => x.toJson()).toList(),
        "meta": meta?.toJson(),
      };

  @override
  List<Object?> get props => [
        success,
        message,
        myPlans,
        meta,
      ];
}

class Meta extends Equatable {
  const Meta({
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

  factory Meta.fromJson(Map<String, dynamic> json) {
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

  @override
  List<Object?> get props => [
        total,
        currentPage,
        perPage,
        lastPage,
      ];
}

class MyPlan extends Equatable {
  const MyPlan({
    required this.id,
    required this.userId,
    required this.planId,
    required this.name,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  final int id;
  final int userId;
  final int planId;
  final String name;
  final String price;
  final DateTime? startDate;
  final DateTime? endDate;
  final num status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

  MyPlan copyWith({
    int? id,
    int? userId,
    int? planId,
    String? name,
    String? price,
    DateTime? startDate,
    DateTime? endDate,
    num? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
  }) {
    return MyPlan(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      planId: planId ?? this.planId,
      name: name ?? this.name,
      price: price ?? this.price,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }

  factory MyPlan.fromJson(Map<String, dynamic> json) {
    return MyPlan(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? 0,
      planId: json["plan_id"] ?? 0,
      name: json["name"] ?? "",
      price: json["price"] ?? "",
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      status: json["status"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "plan_id": planId,
        "name": name,
        "price": price,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        planId,
        name,
        price,
        startDate,
        endDate,
        status,
        createdAt,
        updatedAt,
        user,
      ];
}

class User extends Equatable {
  const User({
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
  final String photo;
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
    dynamic emailVerifiedAt,
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

  factory User.fromJson(Map<String, dynamic> json) {
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
        "photo": photo,
        "phone": phone,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        photo,
        phone,
        email,
        emailVerifiedAt,
        createdAt,
        updatedAt,
      ];
}
