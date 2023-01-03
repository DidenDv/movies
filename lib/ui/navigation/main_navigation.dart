import 'package:flutter/material.dart';
import 'package:movies_mobile/libary/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/widgets/auth_model.dart';
import 'package:movies_mobile/ui/widgets/auth_widget.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:movies_mobile/ui/widgets/my_app/my_app.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const mainDetails = '/movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth ? MainNavigationRouteNames.mainScreen : MainNavigationRouteNames.auth;
  final routes = <String, Widget Function(BuildContext context)> {
    MainNavigationRouteNames.auth: (context) => NotifyProvider(
        model: AuthModel(),
        child: const AuthWidget()
    ),
    MainNavigationRouteNames.mainScreen: (context) => NotifyProvider(
        model: AuthModel(),
        child: const NavigateWidget()
    ),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case MainNavigationRouteNames.mainDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(builder: (context) => MovieDetailsWidget(movieId: movieId));
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}