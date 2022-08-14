import 'package:flutter_app_videoplayer/http/http_manager.dart';

import 'http/Url.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

class AppInit {
  AppInit._();

  static Future<void> init() async {
    Url.baseUrl = 'http://baobab.kaiyanapp.com/api/';
    // Future.delayed(const Duration(milliseconds: 2000), () {
    //   FlutterSplashScreen.hide();
    // });
    HttpManager.get("http://baobab.kaiyanapp.com/api/v2/feed?num=1",
        success: (result) {
      // print(result);
    });
  }
}
