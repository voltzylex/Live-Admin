import 'package:equatable/equatable.dart';

class DashboardModel extends Equatable {
    const DashboardModel({
        required this.success,
        required this.message,
        required this.overview,
        required this.revenueReport,
        required this.userData,
        required this.newMembers,
    });

    final bool success;
    final String message;
    final Overview? overview;
    final RevenueReport? revenueReport;
    final UserData? userData;
    final List<NewMember> newMembers;

    DashboardModel copyWith({
        bool? success,
        String? message,
        Overview? overview,
        RevenueReport? revenueReport,
        UserData? userData,
        List<NewMember>? newMembers,
    }) {
        return DashboardModel(
            success: success ?? this.success,
            message: message ?? this.message,
            overview: overview ?? this.overview,
            revenueReport: revenueReport ?? this.revenueReport,
            userData: userData ?? this.userData,
            newMembers: newMembers ?? this.newMembers,
        );
    }

    factory DashboardModel.fromJson(Map<String, dynamic> json){ 
        return DashboardModel(
            success: json["success"] ?? false,
            message: json["message"] ?? "",
            overview: json["overview"] == null ? null : Overview.fromJson(json["overview"]),
            revenueReport: json["revenue_report"] == null ? null : RevenueReport.fromJson(json["revenue_report"]),
            userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
            newMembers: json["new_members"] == null ? [] : List<NewMember>.from(json["new_members"]!.map((x) => NewMember.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "overview": overview?.toJson(),
        "revenue_report": revenueReport?.toJson(),
        "user_data": userData?.toJson(),
        "new_members": newMembers.map((x) => x.toJson()).toList(),
    };

    @override
    List<Object?> get props => [
    success, message, overview, revenueReport, userData, newMembers, ];
}

class NewMember extends Equatable {
    const NewMember({
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

    NewMember copyWith({
        int? id,
        String? name,
        String? email,
        dynamic emailVerifiedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return NewMember(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory NewMember.fromJson(Map<String, dynamic> json){ 
        return NewMember(
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

class Overview extends Equatable {
    const Overview({
        required this.totalUsers,
        required this.usersThisMonth,
        required this.totalMovies,
        required this.moviesThisMonth,
        required this.activsUsers,
        required this.activeUsersThisMonth,
    });

    final num totalUsers;
    final num usersThisMonth;
    final num totalMovies;
    final num moviesThisMonth;
    final num activsUsers;
    final num activeUsersThisMonth;

    Overview copyWith({
        num? totalUsers,
        num? usersThisMonth,
        num? totalMovies,
        num? moviesThisMonth,
        num? activsUsers,
        num? activeUsersThisMonth,
    }) {
        return Overview(
            totalUsers: totalUsers ?? this.totalUsers,
            usersThisMonth: usersThisMonth ?? this.usersThisMonth,
            totalMovies: totalMovies ?? this.totalMovies,
            moviesThisMonth: moviesThisMonth ?? this.moviesThisMonth,
            activsUsers: activsUsers ?? this.activsUsers,
            activeUsersThisMonth: activeUsersThisMonth ?? this.activeUsersThisMonth,
        );
    }

    factory Overview.fromJson(Map<String, dynamic> json){ 
        return Overview(
            totalUsers: json["total_users"] ?? 0,
            usersThisMonth: json["users_this_month"] ?? 0,
            totalMovies: json["total_movies"] ?? 0,
            moviesThisMonth: json["movies_this_month"] ?? 0,
            activsUsers: json["activs_users"] ?? 0,
            activeUsersThisMonth: json["active_users_this_month"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "total_users": totalUsers,
        "users_this_month": usersThisMonth,
        "total_movies": totalMovies,
        "movies_this_month": moviesThisMonth,
        "activs_users": activsUsers,
        "active_users_this_month": activeUsersThisMonth,
    };

    @override
    List<Object?> get props => [
    totalUsers, usersThisMonth, totalMovies, moviesThisMonth, activsUsers, activeUsersThisMonth, ];
}

class RevenueReport extends Equatable {
    const RevenueReport({
        required this.labels,
        required this.data,
    });

    final List<String> labels;
    final List<num> data;

    RevenueReport copyWith({
        List<String>? labels,
        List<num>? data,
    }) {
        return RevenueReport(
            labels: labels ?? this.labels,
            data: data ?? this.data,
        );
    }

    factory RevenueReport.fromJson(Map<String, dynamic> json){ 
        return RevenueReport(
            labels: json["labels"] == null ? [] : List<String>.from(json["labels"]!.map((x) => x)),
            data: json["data"] == null ? [] : List<num>.from(json["data"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "labels": labels.map((x) => x).toList(),
        "data": data.map((x) => x).toList(),
    };

    @override
    List<Object?> get props => [
    labels, data, ];
}

class UserData extends Equatable {
    const UserData({
        required this.activeUsers,
        required this.inactiveUsers,
        required this.activeUsersPercentage,
        required this.inactiveUsersPercentage,
        required this.newMembers,
    });

    final num activeUsers;
    final num inactiveUsers;
    final num activeUsersPercentage;
    final num inactiveUsersPercentage;
    final num newMembers;

    UserData copyWith({
        num? activeUsers,
        num? inactiveUsers,
        num? activeUsersPercentage,
        num? inactiveUsersPercentage,
        num? newMembers,
    }) {
        return UserData(
            activeUsers: activeUsers ?? this.activeUsers,
            inactiveUsers: inactiveUsers ?? this.inactiveUsers,
            activeUsersPercentage: activeUsersPercentage ?? this.activeUsersPercentage,
            inactiveUsersPercentage: inactiveUsersPercentage ?? this.inactiveUsersPercentage,
            newMembers: newMembers ?? this.newMembers,
        );
    }

    factory UserData.fromJson(Map<String, dynamic> json){ 
        return UserData(
            activeUsers: json["active_users"] ?? 0,
            inactiveUsers: json["inactive_users"] ?? 0,
            activeUsersPercentage: json["active_users_percentage"] ?? 0,
            inactiveUsersPercentage: json["inactive_users_percentage"] ?? 0,
            newMembers: json["new_members"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "active_users": activeUsers,
        "inactive_users": inactiveUsers,
        "active_users_percentage": activeUsersPercentage,
        "inactive_users_percentage": inactiveUsersPercentage,
        "new_members": newMembers,
    };

    @override
    List<Object?> get props => [
    activeUsers, inactiveUsers, activeUsersPercentage, inactiveUsersPercentage, newMembers, ];
}
