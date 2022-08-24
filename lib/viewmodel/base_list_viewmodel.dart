import 'dart:convert';

import 'package:flutter_app_videoplayer/http/http_manager.dart';
import 'package:flutter_app_videoplayer/model/paging_model.dart';
import 'package:flutter_app_videoplayer/util/toast_utils.dart';
import 'package:flutter_app_videoplayer/viewmodel/bash_change_notifier.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListViewModel<T, M extends PagingModel<T>>
    extends BaseChangeNotifier {
  List<T> itemList = [];

  String? nextPageUrl;

  // 获取数据
  void updateData(List<T> list) {
    itemList = list;
  }

  //请求数据地址
  String getUrl();

  //请求返回的真实数据模型
  M getModel(Map<String, dynamic> json);

  // 移除无用数据
  void removeUselessData(List<T> list) {}

  void doExtraAfterLoaded(bool refresh) {}

  //上拉加载/下拉刷新控制器
  RefreshController controller = RefreshController();

  String getNextUrl(M model) {
    return model.nextPageUrl;
  }

  void refresh() {
    _load(refresh: true);
  }

  Future<void> loadMore() async{
    if (nextPageUrl == null) {
      controller.loadNoData();
      return;
    }
    _load(url: nextPageUrl);
  }

  void _load({bool refresh = false, String? url}) {
    viewState = ViewState.loading;
    HttpManager.get(url ?? getUrl(), success: (json) {
      M model = getModel(json);
      removeUselessData(model.itemList);
      updateData(model.itemList);
      if (refresh) {
        itemList.clear();
      }
      itemList.addAll(model.itemList);
      nextPageUrl = getNextUrl(model);
      onComplete(refresh);
      // 做额外的操作：例如加载home的列表数据
      doExtraAfterLoaded(refresh);
    }, fail: (e) {
      MyToast.showError(e.toString());
      onFailed(refresh);
    }, complete: () {
      notifyListeners();
    });
  }

  void onComplete(bool refresh) {
    if (refresh) {
      controller.refreshCompleted();
      controller.footerMode?.value = LoadStatus.canLoading;
    } else {
      controller.loadComplete();
    }
    viewState = ViewState.done;
  }

  void onFailed(bool refresh) {
    if (refresh) {
      controller.refreshFailed();
    } else {
      controller.loadFailed();
    }
    viewState = ViewState.error;
  }

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }
}
