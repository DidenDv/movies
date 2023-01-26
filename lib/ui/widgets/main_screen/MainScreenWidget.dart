import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_mobile/domain/data_provider/session_data_provider.dart';
import 'package:movies_mobile/library/widgets/inherited/provider.dart';
import 'package:movies_mobile/ui/Theme/app_colors.dart';
import 'package:movies_mobile/ui/navigation/main_navigation.dart';
import 'package:movies_mobile/ui/widgets/main_screen/MainScreenModel.dart';
import 'package:movies_mobile/ui/widgets/movie_list/movie_list_model.dart';
import 'package:movies_mobile/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:movies_mobile/ui/widgets/movie_news/movie_news.dart';
import 'package:movies_mobile/ui/widgets/series_list/series_list_model.dart';
import 'package:movies_mobile/ui/widgets/series_list/series_list_widget.dart';

class MainScreenWidget extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MainScreenWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.read<MainScreenModel>(context);
    return MaterialApp(
      title: 'MoviesMobile',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.mainDarkBlue
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'EN'),
      ],
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model?.isAuth == true),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}

class NavigateWidget extends StatefulWidget {
  const NavigateWidget({super.key});

  @override
  State<NavigateWidget> createState() => _NavigateWidget();
}

class _NavigateWidget extends State<NavigateWidget> {
  int _selectedIndex = 0;
  final movieListModel = MovieListModel();
  final seriesListModel = SeriesListModel();
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    if(_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieListModel.setupLocal(context);
    seriesListModel.setupLocal(context);
  }

  void _onExit(BuildContext context) {
    SessionDataProvider().setSessionId(null);
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => _onExit(context), icon: const Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const MovieNewsWidget(),
          NotifierProvider(
              create: () => movieListModel,
              isManagingModel: false,
              child: const MovieListWidget()
          ),
          NotifierProvider(
              create: () => seriesListModel,
              isManagingModel: false,
              child: const SeriesListWidget()
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.mainDarkBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'TV series',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}