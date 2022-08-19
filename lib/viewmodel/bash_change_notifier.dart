import 'package:flutter/material.dart';

enum ViewState { loading, done, error }

class BaseChangeNotifier with ChangeNotifier {
  ViewState viewState = ViewState.loading;
  bool _dispose = false;

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }
}
