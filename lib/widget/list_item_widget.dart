import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/model/common_item.dart';
import 'package:flutter_app_videoplayer/util/cache_image.dart';
import 'package:flutter_app_videoplayer/util/toast_utils.dart';

class ListItemWidget extends StatelessWidget {

  Item item;

  ListItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => MyToast.showTip("点击了"),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Stack(
              children: <Widget>[
                _clipRRectImage(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _clipRRectImage(BuildContext context) {
    // ClipRRect:剪切圆角矩形
    return ClipRRect(
      // Hero动画：界面跳转，关联动画
      borderRadius: BorderRadius.circular(4),
      // Hero动画：界面跳转，关联动画
      child: Hero(
        // tag相同的两个widget，跳转时自动关联动画
        tag: '${item.data!.id}${item.data!.time}',
        child: cacheImage(
          item.data!.cover!.feed!,
          width: MediaQuery.of(context).size.width,
          height: 200,
        ),
      ),
    );
  }
}
