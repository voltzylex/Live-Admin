import 'package:equatable/equatable.dart';

class AddSeriesModel extends Equatable {
  const AddSeriesModel({
    required this.series,
  });

  final AddSeries? series;

  AddSeriesModel copyWith({
    AddSeries? series,
  }) {
    return AddSeriesModel(
      series: series ?? this.series,
    );
  }

  factory AddSeriesModel.fromJson(Map<String, dynamic> json) {
    return AddSeriesModel(
      series: json["series"] == null ? null : AddSeries.fromJson(json["series"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "series": series?.toJson(),
      };

  @override
  List<Object?> get props => [
        series,
      ];
}

class AddSeries extends Equatable {
  const AddSeries({
    required this.name,
    required this.description,
    required this.coverImage,
    required this.seasons,
  });

  final String? name;
  final String? description;
  final String? coverImage;
  final List<AddSeason> seasons;

  AddSeries copyWith({
    String? name,
    String? description,
    String? coverImage,
    List<AddSeason>? seasons,
  }) {
    return AddSeries(
      name: name ?? this.name,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      seasons: seasons ?? this.seasons,
    );
  }

  factory AddSeries.fromJson(Map<String, dynamic> json) {
    return AddSeries(
      name: json["name"],
      description: json["description"],
      coverImage: json["coverImage"],
      seasons: json["seasons"] == null
          ? []
          : List<AddSeason>.from(
              json["seasons"]!.map((x) => AddSeason.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "coverImage": coverImage,
        "seasons": seasons.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        name,
        description,
        coverImage,
        seasons,
      ];
}

class AddSeason extends Equatable {
  const AddSeason({
    required this.seasonNumber,
    required this.description,
    required this.image,
    required this.episodes,
  });

  final num? seasonNumber;
  final String? description;
  final String? image;
  final List<AddEpisode> episodes;

  AddSeason copyWith({
    num? seasonNumber,
    String? description,
    String? image,
    List<AddEpisode>? episodes,
  }) {
    return AddSeason(
      seasonNumber: seasonNumber ?? this.seasonNumber,
      description: description ?? this.description,
      image: image ?? this.image,
      episodes: episodes ?? this.episodes,
    );
  }

  factory AddSeason.fromJson(Map<String, dynamic> json) {
    return AddSeason(
      seasonNumber: json["seasonNumber"],
      description: json["description"],
      image: json["image"],
      episodes: json["episodes"] == null
          ? []
          : List<AddEpisode>.from(
              json["episodes"]!.map((x) => AddEpisode.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "seasonNumber": seasonNumber,
        "description": description,
        "image": image,
        "episodes": episodes.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        seasonNumber,
        description,
        image,
        episodes,
      ];
}

class AddEpisode extends Equatable {
  const AddEpisode({
    required this.episodeNumber,
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  final num? episodeNumber;
  final String? title;
  final String? description;
  final String? thumbnail;

  AddEpisode copyWith({
    num? episodeNumber,
    String? title,
    String? description,
    String? thumbnail,
  }) {
    return AddEpisode(
      episodeNumber: episodeNumber ?? this.episodeNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  factory AddEpisode.fromJson(Map<String, dynamic> json) {
    return AddEpisode(
      episodeNumber: json["episodeNumber"],
      title: json["title"],
      description: json["description"],
      thumbnail: json["thumbnail"],
    );
  }

  Map<String, dynamic> toJson() => {
        "episodeNumber": episodeNumber,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
      };

  @override
  List<Object?> get props => [
        episodeNumber,
        title,
        description,
        thumbnail,
      ];
}
