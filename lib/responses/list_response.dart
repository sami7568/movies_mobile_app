import 'package:movies_app/models/model_movies.dart';

class MoviesResponse {
  final Dates dates;
  final int page;
  final List<MoviesModel> moviesList;
  final int totalPages;
  final int totalResults;

  MoviesResponse({
    required this.dates,
    required this.page,
    required this.moviesList,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      dates:
          json['dates'] != null ? Dates.fromJson(json['dates']) : Dates.empty(),
      page: json['page'] ?? 0,
      moviesList: (json['results'] as List?)
              ?.map((e) => MoviesModel.fromJson(e))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'dates': dates.toJson(),
        'page': page,
        'results': moviesList.map((e) => e.toJson()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults,
      };
}

class Dates {
  final String maximum;
  final String minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json['maximum'] ?? '',
      minimum: json['minimum'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'maximum': maximum,
        'minimum': minimum,
      };

  factory Dates.empty() => Dates(maximum: '', minimum: '');
}
