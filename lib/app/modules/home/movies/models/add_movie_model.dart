import 'package:equatable/equatable.dart';

class AddMovie extends Equatable {
  const AddMovie({
    required this.title,
    this.description,
    this.director,
    this.producer,
    this.releaseYear,
    this.rating,
    required this.poster,
    this.trailerUrl,
    required this.movieUrl,
    required this.categories,
    required this.tags,
  });

  final String title;
  final String? description;
  final String? director;
  final String? producer;
  final num? releaseYear;
  final String? rating;
  final String poster;
  final String? trailerUrl;
  final String movieUrl;
  final List<String> categories;
  final List<String> tags;

  AddMovie copyWith({
    String? title,
    String? description,
    String? director,
    String? producer,
    num? releaseYear,
    String? rating,
    String? poster,
    String? trailerUrl,
    String? movieUrl,
    List<String>? categories,
    List<String>? tags,
  }) {
    return AddMovie(
      title: title ?? this.title,
      description: description ?? this.description,
      director: director ?? this.director,
      producer: producer ?? this.producer,
      releaseYear: releaseYear ?? this.releaseYear,
      rating: rating ?? this.rating,
      poster: poster ?? this.poster,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      movieUrl: movieUrl ?? this.movieUrl,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
    );
  }

  factory AddMovie.fromJson(Map<String, dynamic> json) {
    return AddMovie(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      director: json["director"] ?? "",
      producer: json["producer"] ?? "",
      releaseYear: json["release_year"] ?? 0,
      rating: json["rating"] ?? "",
      poster: json["poster"] ?? "",
      trailerUrl: json["trailer_url"] ?? "",
      movieUrl: json["movie_url"] ?? "",
      categories: json["categories"] == null
          ? []
          : List<String>.from(json["categories"]!.map((x) => x)),
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "director": director,
        "producer": producer,
        "release_year": releaseYear,
        "rating": rating,
        "poster": poster,
        "trailer_url": trailerUrl,
        "movie_url": movieUrl,
        "categories": categories.map((x) => x).toList(),
        "tags": tags.map((x) => x).toList(),
      };

  @override
  List<Object?> get props => [
        title,
        description,
        director,
        producer,
        releaseYear,
        rating,
        poster,
        trailerUrl,
        movieUrl,
        categories,
        tags,
      ];
}
