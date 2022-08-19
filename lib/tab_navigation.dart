import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/config/my_string.dart';
import 'package:flutter_app_videoplayer/page/home/home_page.dart';
import 'package:flutter_app_videoplayer/viewmodel/tab_navigation_viewmodel.dart';
import 'package:flutter_app_videoplayer/widget/provider_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TabNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  late DateTime lastTime;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: PageView(
              controller: _pageController,
              children: [
                HomePage(),
                Container(color: Colors.black),
                Container(color: Colors.brown),
                Container(color: Colors.blueGrey)
              ],
            ),
            bottomNavigationBar: ProviderWidget(
              model: TabNavigationViewModel(),
              builder: (BuildContext context, TabNavigationViewModel model,
                  Widget? child) {
                return BottomNavigationBar(
                  currentIndex: model.currentIndex,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: const Color(0xff000000),
                  unselectedItemColor: const Color(0xff9a9a9a),
                  items: _items(),
                  onTap: (index) {
                    if (model.currentIndex != index) {
                      _pageController.jumpToPage(index);
                      model.changeBottomTabIndex(index);
                    }
                  },
                );
              },
              onModelInit: (model) {
                print('TabNavigation onModelInit');
              },
            )));
  }

  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime) > const Duration(seconds: 2)) {
      lastTime = DateTime.now();
      Fluttertoast.showToast(msg: MyString.exit_tip);
      return false;
    } else {
      return true;
    }
  }

  List<BottomNavigationBarItem> _items() {
    return [
      _bottomItem(MyString.home, 'images/ic_home_normal.png',
          'images/ic_home_selected.png'),
      _bottomItem(MyString.discovery, 'images/ic_discovery_normal.png',
          'images/ic_discovery_selected.png'),
      _bottomItem(MyString.hot, 'images/ic_hot_normal.png',
          'images/ic_hot_selected.png'),
      _bottomItem(MyString.mine, 'images/ic_mine_normal.png',
          'images/ic_mine_selected.png')
    ];
  }

  BottomNavigationBarItem _bottomItem(
      String title, String iconName, String selectedIcon) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          iconName,
          width: 24,
          height: 24,
        ),
        activeIcon: Image.asset(
          selectedIcon,
          width: 24,
          height: 24,
        ),
        label: title);
  }
}
