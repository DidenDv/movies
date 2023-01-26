import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:movies_mobile/domain/api_client/api_client.dart';
import 'package:movies_mobile/domain/data_provider/session_data_provider.dart';
import 'package:movies_mobile/domain/entity/series/series_details.dart';

class SeriesDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();

  final int seriesId;
  SeriesDetails? _seriesDetails;
  String _locale = '';
  bool _isFavorite = false;
  late DateFormat _dateFormat;
  Future<void>? Function()? onSessionExpired;

  SeriesDetails? get seriesDetails => _seriesDetails;

  bool get isFavorite => _isFavorite;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  SeriesDetailsModel(this.seriesId);

  Future<void> setupLocal(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      _seriesDetails = await _apiClient.seriesDetails(seriesId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _apiClient.isFavorite(seriesId, sessionId, 'tv');
      }

      notifyListeners();
    } on ApiClientException catch(e) {
      _handleApiClientException(e);
    }
  }

  Future<void> toggleFavorite() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();
    if (sessionId == null || accountId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();

    try {
      await _apiClient.markAsFavorite(
          accountId: accountId,
          sessionId: sessionId,
          mediaId: seriesId,
          mediaType: MediaType.tv,
          isFavorite: _isFavorite
      );
    } on ApiClientException catch(e) {
      _handleApiClientException(e);
    }
  }

  void _handleApiClientException(ApiClientException exception) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        onSessionExpired?.call();
      break;
    default:
      print('\x1B[33m${ exception }\x1B[0m');
    }
  }
}