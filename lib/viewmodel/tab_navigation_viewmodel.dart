import 'package:flutter_app_videoplayer/viewmodel/bash_change_notifier.dart';

class TabNavigationViewModel extends BaseChangeNotifier {
  int currentIndex = 0;

  changeBottomTabIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
