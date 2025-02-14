import 'package:movies_app/app/app.locator.dart';
import 'package:movies_app/app/api_end_points.dart';
import 'package:movies_app/responses/detail_response.dart';
import 'package:movies_app/responses/videos_response.dart';
import 'package:movies_app/responses/list_response.dart';
import 'package:movies_app/services/api_service.dart';

class DatabaseService {
  final _apiService = locator<ApiService>();

  Future<MoviesResponse> getMoviesList() async {
    final response = await _apiService
        .get(endPoint: moviesList, params: {"api_key": apiKey});
    return MoviesResponse.fromJson(response.data);
  }

  Future<MovieDetailResponse> getMovieDetails(int id) async {
    final response = await _apiService
        .get(endPoint: "movie/$id", params: {"api_key": apiKey});
    return MovieDetailResponse.fromJson(response.data);
  }

  Future<MovieVideosResponse> getMovieVideos(int id) async {
    final response = await _apiService
        .get(endPoint: "movie/$id/videos", params: {"api_key": apiKey});
    return MovieVideosResponse.fromJson(response.data);
  }
}
