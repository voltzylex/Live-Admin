import 'package:equatable/equatable.dart';

class SeriesModel extends Equatable {
  const SeriesModel({
    required this.success,
    required this.message,
    required this.series,
    required this.meta,
  });

  final bool success;
  final String message;
  final List<Series> series;
  final Meta? meta;

  SeriesModel copyWith({
    bool? success,
    String? message,
    List<Series>? series,
    Meta? meta,
  }) {
    return SeriesModel(
      success: success ?? this.success,
      message: message ?? this.message,
      series: series ?? this.series,
      meta: meta ?? this.meta,
    );
  }

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      series: json["series"] == null
          ? []
          : List<Series>.from(json["series"]!.map((x) => Series.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "series": series.map((x) => x.toJson()).toList(),
        "meta": meta?.toJson(),
      };

  @override
  List<Object?> get props => [
        success,
        message,
        series,
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

class Series extends Equatable {
  const Series({
    required this.id,
    required this.title,
    required this.description,
    required this.poster,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
    required this.seasons,
  });

  final int id;
  final String title;
  final String description;
  final String poster;
  final num viewCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Season> seasons;

  Series copyWith({
    int? id,
    String? title,
    String? description,
    String? poster,
    num? viewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Season>? seasons,
  }) {
    return Series(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      poster: poster ?? this.poster,
      viewCount: viewCount ?? this.viewCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      seasons: seasons ?? this.seasons,
    );
  }

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      poster: json["poster"] ?? "",
      viewCount: json["view_count"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      seasons: json["seasons"] == null
          ? []
          : List<Season>.from(json["seasons"]!.map((x) => Season.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "poster": poster,
        "view_count": viewCount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "seasons": seasons.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        poster,
        viewCount,
        createdAt,
        updatedAt,
        seasons,
      ];
}

class Season extends Equatable {
  const Season({
    required this.id,
    required this.seriesId,
    required this.seasonNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.episodes,
  });

  final int id;
  final int seriesId;
  final num seasonNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Episode> episodes;

  Season copyWith({
    int? id,
    int? seriesId,
    num? seasonNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Episode>? episodes,
  }) {
    return Season(
      id: id ?? this.id,
      seriesId: seriesId ?? this.seriesId,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      episodes: episodes ?? this.episodes,
    );
  }

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json["id"] ?? 0,
      seriesId: json["series_id"] ?? 0,
      seasonNumber: json["season_number"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      episodes: json["episodes"] == null
          ? []
          : List<Episode>.from(
              json["episodes"]!.map((x) => Episode.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "series_id": seriesId,
        "season_number": seasonNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "episodes": episodes.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        seriesId,
        seasonNumber,
        createdAt,
        updatedAt,
        episodes,
      ];
}

class Episode extends Equatable {
  const Episode({
    required this.id,
    required this.seasonId,
    required this.episodeNumber,
    required this.title,
    required this.description,
    required this.trailerUrl,
    required this.episodeUrl,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int seasonId;
  final num episodeNumber;
  final String title;
  final String description;
  final String trailerUrl;
  final String episodeUrl;
  final dynamic imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Episode copyWith({
    int? id,
    int? seasonId,
    num? episodeNumber,
    String? title,
    String? description,
    String? trailerUrl,
    String? episodeUrl,
    dynamic imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Episode(
      id: id ?? this.id,
      seasonId: seasonId ?? this.seasonId,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      episodeUrl: episodeUrl ?? this.episodeUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json["id"] ?? 0,
      seasonId: json["season_id"] ?? 0,
      episodeNumber: json["episode_number"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      trailerUrl: json["trailer_url"] ?? "",
      episodeUrl: json["episode_url"] ?? "",
      imageUrl: json["image_url"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "season_id": seasonId,
        "episode_number": episodeNumber,
        "title": title,
        "description": description,
        "trailer_url": trailerUrl,
        "episode_url": episodeUrl,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        seasonId,
        episodeNumber,
        title,
        description,
        trailerUrl,
        episodeUrl,
        imageUrl,
        createdAt,
        updatedAt,
      ];
}
