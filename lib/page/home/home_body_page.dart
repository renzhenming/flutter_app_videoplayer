import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/model/common_item.dart';
import 'package:flutter_app_videoplayer/state/base_list_state.dart';
import 'package:flutter_app_videoplayer/viewmodel/home/home_page_viewmodel.dart';
import 'package:flutter_app_videoplayer/widget/home/banner_widget.dart';

class HomeBodyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState
    extends BaseListState<Item, HomePageViewModel, HomeBodyPage> {
  _banner(model) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BannerWidget(model: model),
      ),
    );
  }

  @override
  Widget getContentChild(HomePageViewModel model) {
    return _banner(model);
  }

  @override
  HomePageViewModel get viewModel => HomePageViewModel();
}
