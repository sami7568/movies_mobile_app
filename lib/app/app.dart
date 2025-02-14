import 'package:movies_app/config/config.dart';
import 'package:movies_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:movies_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:movies_app/ui/views/home/home_view.dart';
import 'package:movies_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:movies_app/services/database_service.dart';
import 'package:movies_app/services/api_service.dart';
import 'package:movies_app/ui/views/movies/movies_view.dart';
import 'package:movies_app/ui/views/search/search_view.dart';
import 'package:movies_app/ui/views/movie_detail/movie_detail_view.dart';
import 'package:movies_app/ui/views/video_player/video_player_view.dart';
import 'package:movies_app/ui/views/ticket/ticket_view.dart';
import 'package:movies_app/ui/bottom_sheets/proceed_to_pay/proceed_to_pay_sheet.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: MoviesView),
    MaterialRoute(page: SearchView),
    MaterialRoute(page: MovieDetailView),
    MaterialRoute(page: VideoPlayerView),
    MaterialRoute(page: TicketView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: Config),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: ProceedToPaySheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
