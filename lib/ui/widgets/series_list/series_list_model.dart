import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_mobile/domain/api_client/api_client.dart';
import 'package:movies_mobile/domain/entity/series/popular_series_response.dart';
import 'package:movies_mobile/domain/entity/series/series.dart';
import 'package:movies_mobile/ui/navigation/main_navigation.dart';
import 'package:movies_mobile/ui/widgets/DropdownButtonModel.dart';

class SeriesListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  static final List<SelectValues> _selectList = [
    SelectValues(1, 'Popular', 'popular'),
    SelectValues(2, 'Top rated', 'top_rated'),
    SelectValues(3, 'Airing today', 'airing_today'),
    SelectValues(4, 'On the air', 'on_the_air')
  ];

  SelectValues _selectListValue = SelectValues(1, 'Popular', 'popular');

  final _series = <Series>[];
  late int _currentPage;
  late int _totalPage;
  var _isLoadingInProgress = false;
  String? _searchQuery;
  String _locale = '';
  Timer? searchDebounce;
  
  List<Series> get series => List.unmodifiable(_series);
  List<SelectValues>? get selectList => _selectList;
  SelectValues? get selectListValue => _selectListValue;
  late DateFormat _dateFormat;

  String stringFromDate(DateTime? date) => date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocal(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    // if(_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(locale);
    await _resetList();
  }

  Future<void> _resetList() async {
    _currentPage = 0;
    _totalPage = 1;
    _series.clear();
    await _loadNextPage();
  }

  Future<PopularSeriesResponse> _loadSeries(int nextPage, String locale, String requestKey) async {
    final query = _searchQuery;
    if(query == null) {
      return await _apiClient.popularSeries(nextPage, _locale, requestKey);
    } else {
      return await _apiClient.searchSeries(nextPage, locale, query);
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;

    try {
      final seriesResponse = await _loadSeries(nextPage, _locale, _selectListValue.requestKey);
      _series.addAll(seriesResponse.series);
      _currentPage = seriesResponse.page;
      _totalPage = seriesResponse.totalPages;
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  void onSeriesTap(BuildContext context, int index) {
    final id = _series[index].id;
    Navigator.of(context).pushNamed(MainNavigationRouteNames.seriesDetails, arguments: id);
  }

  Future<void> onSelect(int? id) async {
    final selectValue = _selectList.firstWhere((element) => element.id == id);
    _selectListValue = selectValue;
    notifyListeners();
    await _resetList();
  }

  Future<void> searchSeries(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(microseconds: 500), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if(searchQuery == _searchQuery) return;
      _searchQuery = searchQuery;
      await _resetList();
    });
  }

  void showedSeriesAtIndex(int idx) {
   if(idx < _series.length -1) return;
   _loadNextPage();
  }
}