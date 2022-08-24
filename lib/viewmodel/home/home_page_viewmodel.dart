import 'package:flutter_app_videoplayer/http/Url.dart';
import 'package:flutter_app_videoplayer/model/common_item.dart';
import 'package:flutter_app_videoplayer/model/issue_model.dart';
import 'package:flutter_app_videoplayer/viewmodel/base_list_viewmodel.dart';

class HomePageViewModel extends BaseListViewModel<Item, IssueEntity> {
  List<Item> bannerList = [];

  @override
  IssueEntity getModel(Map<String, dynamic> json) {
    return IssueEntity.fromJson(json);
  }

  @override
  String getUrl() {
    return Url.feedUrl;
  }

  @override
  void updateData(List<Item> list) {
    bannerList = list;
    itemList.clear();
    //为Banner占位，后面要接list列表
    itemList.add(Item());
  }

  @override
  void removeUselessData(List<Item> list) {
    // 移除类型为 'banner2' 的数据
    list.removeWhere((element) => element.type == 'banner2');
  }

  @override
  void doExtraAfterLoaded(bool refresh) async {
    if (refresh) {
      // 此处调用加载更多，是为了获取首次列表数据，因为第一个列表数据用来做banner数据了。
      await loadMore();
    }
  }
}
