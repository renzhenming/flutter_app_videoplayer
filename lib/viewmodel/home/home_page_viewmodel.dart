import 'package:flutter_app_videoplayer/http/Url.dart';
import 'package:flutter_app_videoplayer/http/http_manager.dart';
import 'package:flutter_app_videoplayer/model/common_item.dart';
import 'package:flutter_app_videoplayer/model/issue_model.dart';
import 'package:flutter_app_videoplayer/viewmodel/bash_change_notifier.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePageViewModel extends BaseChangeNotifier {
  List<Item> bannerList = [];

  refresh() {
    HttpManager.get(Url.feedUrl, success: (json) {
      print('HomePageViewModel json = $json');
      IssueEntity model = IssueEntity.fromJson(json);
      bannerList = model.itemList;
      // 移除类型为 'banner2'
      bannerList.removeWhere((element) => element.type == 'banner2');
      viewState = ViewState.done;
    }, fail: (e) {
      print('HomePageViewModel fail');
      Fluttertoast.showToast(msg: e.toString());
    }, complete: () {
      print('HomePageViewModel complete');
      notifyListeners();
    });
  }

  retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }
}
