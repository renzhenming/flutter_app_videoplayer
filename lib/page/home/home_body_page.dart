import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/viewmodel/home/home_page_viewmodel.dart';
import 'package:flutter_app_videoplayer/widget/home/banner_widget.dart';
import 'package:flutter_app_videoplayer/widget/loading_state_widget.dart';
import 'package:flutter_app_videoplayer/widget/provider_widget.dart';

class HomeBodyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomePageViewModel>(
        model: HomePageViewModel(),
        onModelInit: (model) => model.refresh(),
        builder:
            (BuildContext context, HomePageViewModel model, Widget? child) {
          return LoadingStateWidget(
              viewState: model.viewState,
              retry: model.retry,
              child: _banner(model));
        });
  }

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
}
