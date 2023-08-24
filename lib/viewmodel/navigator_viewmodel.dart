import 'dart:developer';

import 'package:flutter/material.dart';

class NavigatorViewModel extends ChangeNotifier {
  int currentPage = 0;
  int barNavigator = 0;
  //final PageController pageController = PageController();

  moveForward() {
    currentPage++;
                                  barNavigator++;

    log(currentPage.toString());
    notifyListeners();
  }

  moveBackwards() {
    currentPage--;
                                  barNavigator--;
    log(currentPage.toString());

    notifyListeners();
  }

  // void setPage(int page) {
  //   currentPage = page;
  //   log(currentPage.toString());
  //   notifyListeners();
  // }
}
