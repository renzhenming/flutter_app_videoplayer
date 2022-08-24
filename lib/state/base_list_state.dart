import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/model/paging_model.dart';
import 'package:flutter_app_videoplayer/viewmodel/base_list_viewmodel.dart';
import 'package:flutter_app_videoplayer/widget/loading_state_widget.dart';
import 'package:flutter_app_videoplayer/widget/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListState<
        ITEM,
        VIEW_MODEL extends BaseListViewModel<ITEM, PagingModel<ITEM>>,
        WIDGET_IMPL extends StatefulWidget>
    extends State<WIDGET_IMPL> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget getContentChild(VIEW_MODEL model);

  //子类实现，调用时赋值，相当于java中的一个抽象方法被重写后赋值
  VIEW_MODEL get viewModel;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<VIEW_MODEL>(
        model: viewModel,
        onModelInit: (model) => model.refresh(),
        builder: (BuildContext context, VIEW_MODEL model, Widget? child) {
          return LoadingStateWidget(
              viewState: model.viewState,
              retry: model.retry,
              child: Container(
                color: Colors.white,
                child: SmartRefresher(
                  controller: model.controller,
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  enablePullUp: true,
                  child: getContentChild(model),
                ),
              ));
        });
  }
}
