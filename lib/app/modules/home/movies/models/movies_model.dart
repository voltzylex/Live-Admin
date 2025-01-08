import 'package:equatable/equatable.dart';

class MoviesModel extends Equatable {
  const MoviesModel({
    required this.success,
    required this.message,
    required this.movies,
    required this.meta,
  });

  final bool success;
  final String message;
  final List<Movie> movies;
  final Meta? meta;

  MoviesModel copyWith({
    bool? success,
    String? message,
    List<Movie>? movies,
    Meta? meta,
  }) {
    return MoviesModel(
      success: success ?? this.success,
      message: message ?? this.message,
      movies: movies ?? this.movies,
      meta: meta ?? this.meta,
    );
  }

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      movies: json["movies"] == null
          ? []
          : List<Movie>.from(json["movies"]!.map((x) => Movie.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "movies": movies.map((x) => x.toJson()).toList(),
        "meta": meta?.toJson(),
      };

  @override
  List<Object?> get props => [
        success,
        message,
        movies,
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

class Movie extends Equatable {
  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseYear,
    required this.rating,
    required this.poster,
    required this.trailerUrl,
    required this.movieUrl,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
    required this.categories,
    required this.tags,
  });

  final int id;
  final String title;
  final String description;
  final String director;
  final String producer;
  final num releaseYear;
  final String rating;
  final String poster;
  final String trailerUrl;
  final String movieUrl;
  final num viewCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Category> categories;
  final List<Tag> tags;

  Movie copyWith({
    int? id,
    String? title,
    String? description,
    String? director,
    String? producer,
    num? releaseYear,
    String? rating,
    String? poster,
    String? trailerUrl,
    String? movieUrl,
    num? viewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Category>? categories,
    List<Tag>? tags,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      director: director ?? this.director,
      producer: producer ?? this.producer,
      releaseYear: releaseYear ?? this.releaseYear,
      rating: rating ?? this.rating,
      poster: poster ?? this.poster,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      movieUrl: movieUrl ?? this.movieUrl,
      viewCount: viewCount ?? this.viewCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      director: json["director"] ?? "",
      producer: json["producer"] ?? "",
      releaseYear: json["release_year"] ?? 0,
      rating: json["rating"] ?? "",
      poster: json["poster"] ?? "",
      trailerUrl: json["trailer_url"] ?? "",
      movieUrl: json["movie_url"] ?? "",
      viewCount: json["view_count"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      categories: json["categories"] == null
          ? []
          : List<Category>.from(
              json["categories"]!.map((x) => Category.fromJson(x))),
      tags: json["tags"] == null
          ? []
          : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "director": director,
        "producer": producer,
        "release_year": releaseYear,
        "rating": rating,
        "poster": poster,
        "trailer_url": trailerUrl,
        "movie_url": movieUrl,
        "view_count": viewCount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "categories": categories.map((x) => x.toJson()).toList(),
        "tags": tags.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        director,
        producer,
        releaseYear,
        rating,
        poster,
        trailerUrl,
        movieUrl,
        viewCount,
        createdAt,
        updatedAt,
        categories,
        tags,
      ];
}

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final int id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CategoryPivot? pivot;

  Category copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    CategoryPivot? pivot,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pivot: pivot ?? this.pivot,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      pivot:
          json["pivot"] == null ? null : CategoryPivot.fromJson(json["pivot"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
        updatedAt,
        pivot,
      ];
}

class CategoryPivot extends Equatable {
  const CategoryPivot({
    required this.movieId,
    required this.categoryId,
  });

  final int movieId;
  final int categoryId;

  CategoryPivot copyWith({
    int? movieId,
    int? categoryId,
  }) {
    return CategoryPivot(
      movieId: movieId ?? this.movieId,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  factory CategoryPivot.fromJson(Map<String, dynamic> json) {
    return CategoryPivot(
      movieId: json["movie_id"] ?? 0,
      categoryId: json["category_id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "category_id": categoryId,
      };

  @override
  List<Object?> get props => [
        movieId,
        categoryId,
      ];
}

class Tag extends Equatable {
  const Tag({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final int id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final TagPivot? pivot;

  Tag copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    TagPivot? pivot,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pivot: pivot ?? this.pivot,
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      pivot: json["pivot"] == null ? null : TagPivot.fromJson(json["pivot"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
        updatedAt,
        pivot,
      ];
}

class TagPivot extends Equatable {
  const TagPivot({
    required this.movieId,
    required this.tagId,
  });

  final int movieId;
  final int tagId;

  TagPivot copyWith({
    int? movieId,
    int? tagId,
  }) {
    return TagPivot(
      movieId: movieId ?? this.movieId,
      tagId: tagId ?? this.tagId,
    );
  }

  factory TagPivot.fromJson(Map<String, dynamic> json) {
    return TagPivot(
      movieId: json["movie_id"] ?? 0,
      tagId: json["tag_id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "tag_id": tagId,
      };

  @override
  List<Object?> get props => [
        movieId,
        tagId,
      ];
}
