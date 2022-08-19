import 'package:flutter/material.dart';
import 'package:flutter_app_videoplayer/config/color.dart';
import 'package:flutter_app_videoplayer/config/my_string.dart';
import 'package:flutter_app_videoplayer/viewmodel/bash_change_notifier.dart';

class LoadingStateWidget extends StatelessWidget {
  final Widget child;
  final ViewState? viewState;
  final VoidCallback? retry;

  LoadingStateWidget(
      {Key? key, required this.child, this.viewState, this.retry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewState == ViewState.loading) {
      return _loadingView;
    } else if (viewState == ViewState.error) {
      return _errorView;
    } else {
      return child;
    }
  }

  Widget get _errorView {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/ic_error',
            width: 100,
            height: 100,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              MyString.net_request_fail,
              style: TextStyle(color: MyColor.hitTextColor),
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.only(top: 10),
          //   child: OutlinedButton(
          //     onPressed: retry,
          //     // style: ButtonStyle(
          //     //     backgroundColor: MaterialStateProperty.all(Colors.white),
          //     //     overlayColor: MaterialStateProperty.all(Colors.brown)),
          //     child: Text(
          //       MyString.reload_again,
          //       style: TextStyle(color: Colors.black87),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget get _loadingView {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
