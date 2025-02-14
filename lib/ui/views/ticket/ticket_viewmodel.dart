import 'package:movies_app/app/app.bottomsheets.dart';
import 'package:movies_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TicketViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();

  int selectedDateIndex = 0;
  int selectedHallIndex = -1;
  List<String> dateList = ['5 Mar', '6 Mar', '7 Mar', '8 Mar', '9 Mar'];

  void setSelectedDateIndex(int index) {
    selectedDateIndex = index;
    notifyListeners();
  }

  void setSelectedHallIndex(int index) {
    selectedHallIndex = index;
    notifyListeners();
  }

  Future<void> showCustomBottomSheet() async {
    // var response =
    await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.proceedToPay, // Match with what you generated
    );

    // if (response?.confirmed == true) {
    //   print('User confirmed');
    // } else {
    //   print('User cancelled');
    // }
  }
}
