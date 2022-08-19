import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget? child;
  final Function(T)? onModelInit;
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  const ProviderWidget(
      {Key? key,
      required this.model,
      this.child,
      this.onModelInit,
      required this.builder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  late T model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    if (widget.onModelInit != null) {
      widget.onModelInit!(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
