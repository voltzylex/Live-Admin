import 'package:equatable/equatable.dart';
import 'package:live_admin/app/global_imports.dart';

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
      series:
          json["series"] == null ? null : AddSeries.fromJson(json["series"]),
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

  final String name;
  final String description;
  final String coverImage;
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
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      coverImage: json["coverImage"] ?? "",
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
  AddSeason({
    required this.seasonNumber,
    required this.description,
    required this.image,
    required this.episodes,
    this.key,
    this.descriptionController,
  });

  final num seasonNumber;
  final String description;
  final String? image;
  final List<AddEpisode> episodes;
  GlobalKey<FormState>? key;
  TextEditingController? descriptionController;

  AddSeason copyWith({
    num? seasonNumber,
    String? description,
    String? image,
    List<AddEpisode>? episodes,
  }) {
    return AddSeason(
      key: key,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      description: description ?? this.description,
      image: image ?? this.image,
      episodes: episodes ?? this.episodes,
    );
  }

  factory AddSeason.fromJson(Map<String, dynamic> json) {
    return AddSeason(
      seasonNumber: json["seasonNumber"] ?? 0,
      description: json["description"] ?? "",
      image: json["image"] ?? "",
      episodes: json["episodes"] == null
          ? []
          : List<AddEpisode>.from(
              json["episodes"]!.map((x) => AddEpisode.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson({bool showImage = true}) => {
        "seasonNumber": seasonNumber,
        "description": description,
        if (showImage) "image": image,
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
  AddEpisode({
    required this.episodeNumber,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.episodeUrl,
    required this.key,
    this.titleController,
    this.descriptionController,
    this.episodeUrlController,
  });

  final num episodeNumber;
  final String title;
  final String description;
  final String? thumbnail;
  final String episodeUrl;
  GlobalKey<FormState> key;
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  TextEditingController? episodeUrlController;

  AddEpisode copyWith({
    num? episodeNumber,
    String? title,
    String? description,
    String? thumbnail,
    String? episodeUrl,
  }) {
    return AddEpisode(
        episodeNumber: episodeNumber ?? this.episodeNumber,
        title: title ?? this.title,
        description: description ?? this.description,
        thumbnail: thumbnail ?? this.thumbnail,
        episodeUrl: episodeUrl ?? this.episodeUrl,
        key: key);
  }

  factory AddEpisode.fromJson(Map<String, dynamic> json) {
    return AddEpisode(
      key: json["key"],
      episodeNumber: json["episodeNumber"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      thumbnail: json["thumbnail"],
      episodeUrl: json["url"] ?? "",
    );
  }

  Map<String, dynamic> toJson({bool showImage = true}) => {
        "episodeNumber": episodeNumber,
        "title": title,
        "description": description,
        if (showImage) "thumbnail": thumbnail,
        "url": episodeUrl,
      };

  @override
  List<Object?> get props => [
        episodeNumber,
        title,
        description,
        thumbnail,
        episodeUrl,
      ];
}
