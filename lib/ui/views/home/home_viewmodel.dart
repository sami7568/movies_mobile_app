import 'package:flutter/material.dart';
import 'package:movies_app/ui/views/movies/movies_view.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  int currentIndex = 1;

  List<Widget> allScreens = const [
    MoviesView(),
    MoviesView(),
    MoviesView(),
    MoviesView(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
