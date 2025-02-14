class MovieVideosResponse {
  int id;
  List<MovieDetail> movieDetails;

  MovieVideosResponse({required this.id, required this.movieDetails});

  MovieVideosResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        movieDetails = (json['results'] as List<dynamic>?)
                ?.map((e) => MovieDetail.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'results': movieDetails.map((e) => e.toJson()).toList(),
    };
  }
}

class MovieDetail {
  String iso6391;
  String iso31661;
  String name;
  String key;
  String site;
  int size;
  String type;
  bool official;
  String publishedAt;
  String id;

  MovieDetail({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  MovieDetail.fromJson(Map<String, dynamic> json)
      : iso6391 = json['iso_639_1'] ?? '',
        iso31661 = json['iso_3166_1'] ?? '',
        name = json['name'] ?? '',
        key = json['key'] ?? '',
        site = json['site'] ?? '',
        size = json['size'] ?? 0,
        type = json['type'] ?? '',
        official = json['official'] ?? false,
        publishedAt = json['published_at'] ?? '',
        id = json['id'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'iso_639_1': iso6391,
      'iso_3166_1': iso31661,
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': type,
      'official': official,
      'published_at': publishedAt,
      'id': id,
    };
  }
}
