import 'package:equatable/equatable.dart';

class AddSubscribeModel extends Equatable {
    AddSubscribeModel({
        required this.userId,
        required this.planId,
        required this.startDate,
    });

    final int userId;
    final int planId;
    final DateTime? startDate;

    AddSubscribeModel copyWith({
        int? userId,
        int? planId,
        DateTime? startDate,
    }) {
        return AddSubscribeModel(
            userId: userId ?? this.userId,
            planId: planId ?? this.planId,
            startDate: startDate ?? this.startDate,
        );
    }

    factory AddSubscribeModel.fromJson(Map<String, dynamic> json){ 
        return AddSubscribeModel(
            userId: json["user_id"] ?? 0,
            planId: json["plan_id"] ?? 0,
            startDate: DateTime.tryParse(json["start_date"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "plan_id": planId,
        "start_date": startDate?.toIso8601String(),
    };

    @override
    List<Object?> get props => [
    userId, planId, startDate, ];
}
