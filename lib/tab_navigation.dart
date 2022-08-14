import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/config/my_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TabNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  late DateTime lastTime;

  Widget _currentBody = Container(color: Colors.yellow);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: _currentBody,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xff000000),
              unselectedItemColor: Color(0xff9a9a9a),
              items: _items(),
              onTap: _onTap,
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

  _onTap(int index) {
    print("index = $index");
    switch (index) {
      case 0:
        _currentBody = Container(color: Colors.yellow);
        break;
      case 1:
        _currentBody = Container(color: Colors.orange);
        break;
      case 2:
        _currentBody = Container(color: Colors.blue);
        break;
      case 3:
        _currentBody = Container(color: Colors.green);
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }
}
