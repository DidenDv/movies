import 'package:flutter/material.dart';

class NotifyProvider<Model extends ChangeNotifier> extends InheritedNotifier {
  final Model model;
  const NotifyProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key,notifier: model, child: child);

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NotifyProvider<Model>>()?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<NotifyProvider<Model>>()?.widget;
    return widget is NotifyProvider<Model> ? widget.model : null;
  }
}

class Provider<Model> extends InheritedWidget {
  final Model model;
  const Provider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static Model? watch<Model>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<Model>>()?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<Provider<Model>>()?.widget;
    return widget is Provider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(Provider old) {
    return model != old.model;
  }
}
