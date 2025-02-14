import 'package:movies_app/app/app.locator.dart';
import 'package:movies_app/responses/videos_response.dart';
import 'package:movies_app/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  late YoutubePlayerController controller;
  bool isVideoLoading = true;
  final _navigationService = locator<NavigationService>();

  Future<void> fetchVideoDetails(int id) async {
    setBusy(true);
    MovieVideosResponse response = await _dbService.getMovieVideos(id);
    initPlayer(response.movieDetails.first.key);
    setBusy(false);
  }

  void initPlayer(String videoKey) async {
    controller = YoutubePlayerController(
      initialVideoId: videoKey, // Video key from API response
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(() {
        if (controller.value.playerState == PlayerState.ended) {
          // controller.dispose();
          _navigationService.back();
        }
      });
    isVideoLoading = false;
    notifyListeners();
  }

  void goBack() {
    _navigationService.back();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
