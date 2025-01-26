import 'package:equatable/equatable.dart';

class SubscribeModel extends Equatable {
    SubscribeModel({
        required this.success,
        required this.message,
        required this.subscription,
        required this.daysLeft,
    });

    final bool success;
    final String message;
    final Subscription? subscription;
    final num daysLeft;

    SubscribeModel copyWith({
        bool? success,
        String? message,
        Subscription? subscription,
        num? daysLeft,
    }) {
        return SubscribeModel(
            success: success ?? this.success,
            message: message ?? this.message,
            subscription: subscription ?? this.subscription,
            daysLeft: daysLeft ?? this.daysLeft,
        );
    }

    factory SubscribeModel.fromJson(Map<String, dynamic> json){ 
        return SubscribeModel(
            success: json["success"] ?? false,
            message: json["message"] ?? "",
            subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
            daysLeft: json["days_left"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "subscription": subscription?.toJson(),
        "days_left": daysLeft,
    };

    @override
    List<Object?> get props => [
    success, message, subscription, daysLeft, ];
}

class Subscription extends Equatable {
    Subscription({
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

    Subscription copyWith({
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
    }) {
        return Subscription(
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
        );
    }

    factory Subscription.fromJson(Map<String, dynamic> json){ 
        return Subscription(
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
    };

    @override
    List<Object?> get props => [
    id, userId, planId, name, price, startDate, endDate, status, createdAt, updatedAt, ];
}
