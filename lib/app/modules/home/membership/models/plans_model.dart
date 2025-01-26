import 'package:equatable/equatable.dart';

class PlansModel extends Equatable {
    PlansModel({
        required this.success,
        required this.message,
        required this.plans,
    });

    final bool success;
    final String message;
    final List<Plan> plans;

    PlansModel copyWith({
        bool? success,
        String? message,
        List<Plan>? plans,
    }) {
        return PlansModel(
            success: success ?? this.success,
            message: message ?? this.message,
            plans: plans ?? this.plans,
        );
    }

    factory PlansModel.fromJson(Map<String, dynamic> json){ 
        return PlansModel(
            success: json["success"] ?? false,
            message: json["message"] ?? "",
            plans: json["plans"] == null ? [] : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "plans": plans.map((x) => x?.toJson()).toList(),
    };

    @override
    List<Object?> get props => [
    success, message, plans, ];
}

class Plan extends Equatable {
    Plan({
        required this.id,
        required this.name,
        required this.price,
        required this.duration,
        required this.maxQuality,
        required this.maxDevice,
        required this.resolution,
        required this.support,
        required this.trialPeriod,
        required this.status,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    final int id;
    final String name;
    final num price;
    final num duration;
    final dynamic maxQuality;
    final num maxDevice;
    final dynamic resolution;
    final bool support;
    final num trialPeriod;
    final bool status;
    final String description;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Plan copyWith({
        int? id,
        String? name,
        num? price,
        num? duration,
        dynamic? maxQuality,
        num? maxDevice,
        dynamic? resolution,
        bool? support,
        num? trialPeriod,
        bool? status,
        String? description,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return Plan(
            id: id ?? this.id,
            name: name ?? this.name,
            price: price ?? this.price,
            duration: duration ?? this.duration,
            maxQuality: maxQuality ?? this.maxQuality,
            maxDevice: maxDevice ?? this.maxDevice,
            resolution: resolution ?? this.resolution,
            support: support ?? this.support,
            trialPeriod: trialPeriod ?? this.trialPeriod,
            status: status ?? this.status,
            description: description ?? this.description,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory Plan.fromJson(Map<String, dynamic> json){ 
        return Plan(
            id: json["id"] ?? 0,
            name: json["name"] ?? "",
            price: json["price"] ?? 0,
            duration: json["duration"] ?? 0,
            maxQuality: json["max_quality"],
            maxDevice: json["max_device"] ?? 0,
            resolution: json["resolution"],
            support: json["support"] ?? false,
            trialPeriod: json["trial_period"] ?? 0,
            status: json["status"] ?? false,
            description: json["description"] ?? "",
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "duration": duration,
        "max_quality": maxQuality,
        "max_device": maxDevice,
        "resolution": resolution,
        "support": support,
        "trial_period": trialPeriod,
        "status": status,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

    @override
    List<Object?> get props => [
    id, name, price, duration, maxQuality, maxDevice, resolution, support, trialPeriod, status, description, createdAt, updatedAt, ];
}
