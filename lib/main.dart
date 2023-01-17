import 'package:flutter/material.dart';
import 'package:movies_mobile/ui/widgets/main_screen/MainScreenModel.dart';
import 'package:movies_mobile/ui/widgets/main_screen/MainScreenWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MainScreenModel();
  await model.checkAuth();
  final app = MainScreenWidget(model: model);
  runApp(app);
}