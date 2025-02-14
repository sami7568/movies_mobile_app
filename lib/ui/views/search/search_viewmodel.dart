// import 'package:movies_app/responses/movie_response.dart';
import 'package:movies_app/models/model_movies.dart';
import 'package:movies_app/responses/list_response.dart';
import 'package:stacked/stacked.dart';
// import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/services/database_service.dart';

class SearchViewModel extends BaseViewModel {
  final DatabaseService _databaseService = DatabaseService();

  List<MoviesModel> allMovies = [];
  List<MoviesModel> filteredMovies = [];
  List<MoviesModel> finalResults = [];
  bool isSearching = false;
  bool searchFinalized = false;
  String searchQuery = "";
  bool isLoading = true;

  SearchViewModel() {
    fetchMovies();
  }

  /// Fetch all movies initially
  Future<void> fetchMovies() async {
    setBusy(true);

    final MoviesResponse response = await _databaseService.getMoviesList();
    allMovies = response.moviesList;
    filteredMovies = List.from(allMovies);
    isLoading = false;
    setBusy(false);
    notifyListeners();
  }

  /// Live Search Suggestions (Triggered as User Types)
  void searchMovies(String query) {
    searchQuery = query;
    searchFinalized = false;
    if (query.isEmpty) {
      filteredMovies = List.from(allMovies);
      isSearching = false;
    } else {
      isSearching = true;
      filteredMovies = allMovies
          .where((movie) =>
              movie.title.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  /// Final Search (Triggered When Enter/Go Pressed)
  void finalizeSearch() {
    if (searchQuery.isNotEmpty) {
      searchFinalized = true;
      finalResults = List.from(filteredMovies);
    }
    notifyListeners();
  }
}
