
class MovieDetailResponse {
  bool adult;
  String backdropPath;
  BelongsToCollection? belongsToCollection;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  String imdbId;
  List<String> originCountry;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompanies> productionCompanies;
  List<ProductionCountries> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguages> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  MovieDetailResponse.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'] ?? "",
        belongsToCollection = json['belongs_to_collection'] != null
            ? BelongsToCollection.fromJson(json['belongs_to_collection'])
            : null,
        budget = json['budget'],
        genres =
            (json['genres'] as List).map((v) => Genres.fromJson(v)).toList(),
        homepage = json['homepage'],
        id = json['id'],
        imdbId = json['imdb_id'],
        originCountry = List<String>.from(json['origin_country']),
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        productionCompanies = (json['production_companies'] as List)
            .map((v) => ProductionCompanies.fromJson(v))
            .toList(),
        productionCountries = (json['production_countries'] as List)
            .map((v) => ProductionCountries.fromJson(v))
            .toList(),
        releaseDate = json['release_date'],
        revenue = json['revenue'],
        runtime = json['runtime'],
        spokenLanguages = (json['spoken_languages'] as List)
            .map((v) => SpokenLanguages.fromJson(v))
            .toList(),
        status = json['status'],
        tagline = json['tagline'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];

 

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'belongs_to_collection': belongsToCollection?.toJson(),
        'budget': budget,
        'genres': genres.map((v) => v.toJson()).toList(),
        'homepage': homepage,
        'id': id,
        'imdb_id': imdbId,
        'origin_country': originCountry,
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'production_companies':
            productionCompanies.map((v) => v.toJson()).toList(),
        'production_countries':
            productionCountries.map((v) => v.toJson()).toList(),
        'release_date': releaseDate,
        'revenue': revenue,
        'runtime': runtime,
        'spoken_languages': spokenLanguages.map((v) => v.toJson()).toList(),
        'status': status,
        'tagline': tagline,
        'title': title,
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  //post url getter
  //get poster url
  String get posterUrl => 'https://image.tmdb.org/t/p/w500/$posterPath';

  //get backdrop url
  String get backdropUrl => 'https://image.tmdb.org/t/p/w780/$backdropPath';
}

class BelongsToCollection {
  int id;
  String name;
  String posterPath;
  String backdropPath;

  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  BelongsToCollection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? "",
        posterPath = json['poster_path'] ?? "",
        backdropPath = json['backdrop_path'] ?? "";

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'poster_path': posterPath,
        'backdrop_path': backdropPath,
      };
  //get poster url
  String get posterUrl => 'https://image.tmdb.org/t/p/w500/$posterPath';

  //get backdrop url
  String get backdropUrl => 'https://image.tmdb.org/t/p/w780/$backdropPath';
}

class Genres {
  int id;
  String name;

  Genres({required this.id, required this.name});

  Genres.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? "";

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class ProductionCompanies {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompanies({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  ProductionCompanies.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        logoPath = json['logo_path'] ?? "",
        name = json['name'] ?? "",
        originCountry = json['origin_country'] ?? "";

  Map<String, dynamic> toJson() => {
        'id': id,
        'logo_path': logoPath,
        'name': name,
        'origin_country': originCountry,
      };
}

class ProductionCountries {
  String iso31661;
  String name;

  ProductionCountries({required this.iso31661, required this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json)
      : iso31661 = json['iso_3166_1'] ?? "",
        name = json['name'] ?? "";

  Map<String, dynamic> toJson() => {
        'iso_3166_1': iso31661,
        'name': name,
      };
}

class SpokenLanguages {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguages({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  SpokenLanguages.fromJson(Map<String, dynamic> json)
      : englishName = json['english_name'] ?? "",
        iso6391 = json['iso_639_1'] ?? "",
        name = json['name'] ?? "";

  Map<String, dynamic> toJson() => {
        'english_name': englishName,
        'iso_639_1': iso6391,
        'name': name,
      };
}
