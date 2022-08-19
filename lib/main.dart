import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/app_init.dart';
import 'package:flutter_app_videoplayer/http/http_manager.dart';
import 'package:flutter_app_videoplayer/tab_navigation.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print('=== initState');
  }

  @override
  void didUpdateWidget(covariant MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('=== didUpdateWidget');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('=== didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('=== build');
    return FutureBuilder(
        future: AppInit.init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          print(snapshot.connectionState);
          var widget = snapshot.connectionState == ConnectionState.done
              ? TabNavigation()
              : const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          return _GetMaterialAppWidget(child: widget);
        });
  }

  @override
  void deactivate() {
    super.deactivate();
    print('=== deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('=== dispose');
  }
}

class _GetMaterialAppWidget extends StatefulWidget {
  Widget child;

  _GetMaterialAppWidget({required this.child});

  @override
  State<StatefulWidget> createState() {
    return _GetMaterialAppWidgetState();
  }
}

class _GetMaterialAppWidgetState extends State<_GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: "_GetMaterialAppWidgetState",
    //   initialRoute: "/",
    //   routes: {
    //     "/": (context) => widget.child,
    //   },
    // );

    return GetMaterialApp(
      title: "_GetMaterialAppWidgetState",
      initialRoute: '/',
      getPages: [GetPage(name: '/', page: () => widget.child)],
    );
  }
}
