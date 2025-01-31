import 'package:equatable/equatable.dart';
import 'package:live_admin/app/modules/home/membership/models/membership_model.dart';

class MembershipHistoryModel extends Equatable {
  const MembershipHistoryModel({
    required this.success,
    required this.message,
    required this.plans,
    required this.user,
  });

  final bool success;
  final String message;
  final List<MyPlan> plans;
  final User? user;

  MembershipHistoryModel copyWith({
    bool? success,
    String? message,
    List<MyPlan>? plans,
    User? user,
  }) {
    return MembershipHistoryModel(
      success: success ?? this.success,
      message: message ?? this.message,
      plans: plans ?? this.plans,
      user: user ?? this.user,
    );
  }

  factory MembershipHistoryModel.fromJson(Map<String, dynamic> json) {
    return MembershipHistoryModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      plans: json["plans"] == null
          ? []
          : List<MyPlan>.from(json["plans"]!.map((x) => MyPlan.fromJson(x))),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "plans": plans.map((x) => x.toJson()).toList(),
        "user": user?.toJson(),
      };

  @override
  List<Object?> get props => [
        success,
        message,
        plans,
        user,
      ];
}
