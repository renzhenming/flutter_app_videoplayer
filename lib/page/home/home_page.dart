import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/page/home/home_body_page.dart';
import 'package:flutter_app_videoplayer/widget/app_bar.dart';

import '../../config/my_string.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        MyString.home,
        showBack: false,
      ),
      body: HomeBodyPage(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
