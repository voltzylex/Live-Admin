import 'package:equatable/equatable.dart';

class AddSeries extends Equatable {
  const AddSeries({
    required this.title,
    required this.description,
    required this.poster,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final String title;
  final String description;
  final String poster;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int id;

  AddSeries copyWith({
    String? title,
    String? description,
    String? poster,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) {
    return AddSeries(
      title: title ?? this.title,
      description: description ?? this.description,
      poster: poster ?? this.poster,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  factory AddSeries.fromJson(Map<String, dynamic> json) {
    return AddSeries(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      poster: json["poster"] ?? "",
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "poster": poster,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };

  @override
  List<Object?> get props => [
        title,
        description,
        poster,
        updatedAt,
        createdAt,
        id,
      ];
}
