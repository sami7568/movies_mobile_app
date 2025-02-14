import 'package:stacked/stacked.dart';

class TicketViewModel extends BaseViewModel {
  int selectedDateIndex = 0;
  int selectedHallIndex = -1;
  List<String> dateList = ['5 Mar', '6 Mar', '7 Mar', '8 Mar', '9 Mar'];

  void setSelectedDateIndex(int index) {
    selectedDateIndex = index;
    notifyListeners();
  }

  void setSelectedHallIndex(int index){
    selectedHallIndex = index;
    notifyListeners();
  }
}
