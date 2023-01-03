import 'package:flutter/material.dart';
import 'package:movies_mobile/domain/data_provider/session_data_provider.dart';
import 'package:movies_mobile/ui/Theme/app_colors.dart';
import 'package:movies_mobile/ui/navigation/main_navigation.dart';
import 'package:movies_mobile/ui/widgets/main_screen/MainScreenWidget.dart';
import 'package:movies_mobile/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:movies_mobile/ui/widgets/my_app/my_app_models.dart';

class MyApp extends StatelessWidget {
  final MyAppModel model;
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoviesMobile',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.mainDarkBlue
        ),
      ),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
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
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const MainScreenWidget(),
    const MovieListWidget(),
    const Center(
      child: Text(
        'TV series',
        style: optionStyle,
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          IconButton(onPressed: () => _onExit(context), icon: Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
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