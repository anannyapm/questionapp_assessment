import 'dart:developer';

import 'package:flutter/material.dart';

class NavigatorViewModel extends ChangeNotifier {
  int currentPage = 0;
  int barNavigator = 0;
  
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
}
