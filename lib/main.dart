import 'package:flutter/material.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/widgets/main_screen/MainScreenModel.dart';
import 'package:movies_mobile/ui/widgets/main_screen/MainScreenWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MainScreenModel();
  await model.checkAuth();
  const app = MainScreenWidget();
  final widget = Provider(model: model, child: app,);
  runApp(widget);
}