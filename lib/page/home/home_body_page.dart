import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/model/common_item.dart';
import 'package:flutter_app_videoplayer/state/base_list_state.dart';
import 'package:flutter_app_videoplayer/viewmodel/home/home_page_viewmodel.dart';
import 'package:flutter_app_videoplayer/widget/home/banner_widget.dart';
import 'package:flutter_app_videoplayer/widget/list_item_widget.dart';

const TEXT_HEADER_TYPE = 'textHeader';

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

  _title(Item item) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white24),
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: const Center(
        child: Text(
          "item!.data!.text!",
          style: TextStyle(
              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget getContentChild(HomePageViewModel model) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _banner(model);
          } else {
            if (model.itemList[index].type == TEXT_HEADER_TYPE) {
              return _title(model.itemList[index]);
            }
            return ListItemWidget(item: model.itemList[index]);
          }
          return Container(
            color: Colors.red,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Divider(
              height: 0.5,
              color: Color(0xffe6e6e6),
              // height:
              //     model.itemList[index].type == TEXT_HEADER_TYPE || index == 0
              //         ? 0
              //         : 0.5,
              // color:
              //     model.itemList[index].type == TEXT_HEADER_TYPE || index == 0
              //         ? Colors.transparent
              //         : Color(0xffe6e6e6),
            ),
          );
        },
        itemCount: model.itemList.length);
  }

  @override
  HomePageViewModel get viewModel => HomePageViewModel();
}
