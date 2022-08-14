import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/app_init.dart';
import 'package:flutter_app_videoplayer/http/http_manager.dart';
import 'package:flutter_app_videoplayer/tab_navigation.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

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
  }

  @override
  Widget build(BuildContext context) {
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
    return MaterialApp(
      title: "_GetMaterialAppWidgetState",
      initialRoute: "/",
      routes: {
        "/": (context) => widget.child,
      },
    );
  }
}
