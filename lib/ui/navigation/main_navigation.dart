import 'package:flutter/material.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/widgets/auth_model.dart';
import 'package:movies_mobile/ui/widgets/auth_widget.dart';
import 'package:movies_mobile/ui/widgets/main_screen/MainScreenWidget.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_model.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:movies_mobile/ui/widgets/movie_details/movie_trailer_widget.dart';
import 'package:movies_mobile/ui/widgets/series_details/series_details_model.dart';
import 'package:movies_mobile/ui/widgets/series_details/series_details_widget.dart';
import 'package:movies_mobile/ui/widgets/series_details/series_trailer_widget.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const movieTrailer = '/movie_details/trailer';

  static const seriesDetails = '/series_details';
  static const seriesTrailer = '/series_details/trailer';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;
  final routes = <String, Widget Function(BuildContext context)>{
    MainNavigationRouteNames.auth: (context) => NotifierProvider(
          create: () => AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRouteNames.mainScreen: (context) => NotifierProvider(
          create: () => AuthModel(),
          child: const NavigateWidget(),
        ),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            create: () => MovieDetailsModel(movieId),
            child: const MovieDetailsWidget(),
          ),
        );
      case MainNavigationRouteNames.seriesDetails:
        final arguments = settings.arguments;
        final seriesId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            create: () => SeriesDetailsModel(seriesId),
            child: const SeriesDetailsWidget(),
          ),
        );
      case MainNavigationRouteNames.movieTrailer:
        final arguments = settings.arguments;
        final trailerKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => MovieTrailerWidget(
            youtubeKey: trailerKey,
          ),
        );
      case MainNavigationRouteNames.seriesTrailer:
        final arguments = settings.arguments;
        final trailerKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => SeriesTrailerWidget(
            youtubeKey: trailerKey,
          ),
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
