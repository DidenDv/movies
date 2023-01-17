import 'package:flutter/material.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/widgets/auth_model.dart';
import 'package:movies_mobile/ui/widgets/auth_widget.dart';
import 'package:movies_mobile/ui/widgets/main_screen/MainScreenWidget.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_model.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_widget.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth ? MainNavigationRouteNames.mainScreen : MainNavigationRouteNames.auth;
  final routes = <String, Widget Function(BuildContext context)> {
    MainNavigationRouteNames.auth: (context) => NotifierProvider(
        create: () => AuthModel(),
        child: const AuthWidget()
    ),
    MainNavigationRouteNames.mainScreen: (context) => NotifierProvider(
        create: () => AuthModel(),
        child: const NavigateWidget()
    ),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            create: () => MovieDetailsModel(movieId),
            child: const MovieDetailsWidget()
        ),
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}