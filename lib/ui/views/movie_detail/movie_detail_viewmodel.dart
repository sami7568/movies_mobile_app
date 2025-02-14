import 'package:movies_app/app/app.locator.dart';
import 'package:movies_app/app/app.router.dart';
import 'package:movies_app/responses/detail_response.dart';
import 'package:movies_app/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MovieDetailViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final _navigationService = locator<NavigationService>();

  Future<MovieDetailResponse> fetchMovieDetail(id) async {
    // setBusy(true);
    MovieDetailResponse response = await _dbService.getMovieDetails(id);
    // print(response.title);
    return response;
    // setBusy(false);
  }

  void navigateToTrailer(int id) {
    _navigationService.navigateToVideoPlayerView(id: id);
  }

  void navigateToTickets(int id) {
    _navigationService.navigateToTicketView(id: id);
  }
}
