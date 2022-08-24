import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/model/common_item.dart';
import 'package:flutter_app_videoplayer/util/cache_image.dart';
import 'package:flutter_app_videoplayer/util/date_util.dart';
import 'package:flutter_app_videoplayer/util/share_util.dart';
import 'package:flutter_app_videoplayer/util/toast_utils.dart';

class ListItemWidget extends StatelessWidget {
  Item item;
  bool showCategory;
  bool showDivider;

  ListItemWidget(
      {Key? key,
      required this.item,
      this.showCategory = true,
      this.showDivider = true})
      : super(key: key);

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
                _categoryText(),
                _videoTime(),
              ],
            ),
          ),
        ),
        // 视频内容简介
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          // Row：水平布局，类似Android LinearLayout
          child: Row(
            children: [
              _authorHeaderImage(item),
              // Expanded:具有权重属性的组件，可以控制Row、Column、Flex的子控件如何布局的控件。
              _videoDescription(),
              _shareButton(),
            ],
          ),
        ),
        // 分割线
        // Offstage:控制是否显示组件，false 显示,类似 GONE，不会占用空间
        Offstage(
          offstage: showDivider,
          child: const Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Divider(
              height: 1,
              color: Colors.red,
            ),
          ),
        )
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

  _categoryText() {
    // Positioned:用于定位Stack子组件，Positioned必须是Stack的子组件
    return Positioned(
      left: 15,
      top: 10,
      // Opacity:设置透明度，类似于Android中的invisible
      child: Opacity(
        opacity: showCategory ? 1.0 : 0.0, //处理控件显示或隐藏
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(Radius.circular(22))),
          height: 44,
          width: 44,
          alignment: AlignmentDirectional.center,
          child: Text(
            item.data?.category ?? '',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }

  _videoTime() {
    print('item.data?.duration = ${item.data?.duration}');
    return Positioned(
        right: 15,
        bottom: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: const BoxDecoration(color: Colors.black54),
            padding: const EdgeInsets.all(5),
            child: Text(
              formatDateMsByMS(item.data?.duration == null
                  ? 1000
                  : item.data!.duration! * 1000),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  _authorHeaderImage(Item item) {
    // ClipOval:剪切椭圆，高宽一样则为圆
    // ClipOval:剪切椭圆，高宽一样则为圆
    return ClipOval(
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
      child: cacheImage(
        item.data?.author?.icon ?? "icon",
        width: 40,
        height: 40,
      ),
    );
  }

  _videoDescription() {
    // Expanded:相当于Android中设置 weight 权重
    return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          // 垂直的LinearLayout
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.data?.title ?? "defalut",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                // 过长则省略
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(item.data?.description ?? "",
                      style: const TextStyle(
                          color: Color(0xff9a9a9a), fontSize: 12)))
            ],
          ),
        ));
  }

  /// 分享按钮
  _shareButton() {
    return IconButton(
        onPressed: () {
          share(item.data!.title!, item.data!.playUrl!);
          MyToast.showTip("share");
        },
        icon: const Icon(
          Icons.share,
          color: Colors.black38,
        ));
  }
}
