import 'package:flutter/material.dart';
import 'package:movies_mobile/ui/widgets/my_app/my_app.dart';
import 'package:movies_mobile/ui/widgets/my_app/my_app_models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  await model.checkAuth();
  final app = MyApp(model: model);
  runApp(app);
}