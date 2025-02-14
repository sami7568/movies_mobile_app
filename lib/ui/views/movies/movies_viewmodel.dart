import 'package:movies_app/app/app.locator.dart';
import 'package:movies_app/app/app.router.dart';
import 'package:movies_app/models/model_movies.dart';
import 'package:movies_app/responses/list_response.dart';
import 'package:movies_app/services/database_service.dart';
import 'package:movies_app/ui/views/movie_detail/movie_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MoviesViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();
  final navigationService = locator<NavigationService>();
  List<MoviesModel> moviesList = [];

  Future<List<MoviesModel>> fetchMovies() async {
    // setBusy(true);
    final MoviesResponse response = await _databaseService.getMoviesList();
    // print(response.toJson());
    // setBusy(false);
    return response.moviesList;
  }

  navigateToSearchView() {
    navigationService.navigateTo(Routes.searchView);
  }

  navigateToMoviesDetailView(int id) {
    navigationService.navigateToView(MovieDetailView(id: id)
        // Routes.movieDetailView,
        // arguments: {
        // "id": id.toString(),
        // },
        );
  }
}
