import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_mobile/domain/api_client/api_client.dart';
import 'package:movies_mobile/domain/entity/movie/actor_details.dart';
import 'package:movies_mobile/ui/navigation/main_navigation.dart';

class ActorDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final int actorId;
  ActorDetails? _actorDetails;
  String _locale = '';
  late DateFormat _dateFormat;
  Future<void>? Function()? onSessionExpired;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  ActorDetails? get actorDetails => _actorDetails;

  ActorDetailsModel(this.actorId);

  Future<void> setupLocal(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(locale);
    await loadActorDetails();
  }

  Future<void> loadActorDetails() async {
    try {
      _actorDetails = await _apiClient.actorDetails(actorId, _locale);

      notifyListeners();
    } on ApiClientException catch(e) {
      _handleApiClientException(e);
    }
  }

  void onActorDetailsTap(BuildContext context, int id) {
    print('\x1B[33m${ 123123123 }\x1B[0m');
    Navigator.of(context).pushNamed(MainNavigationRouteNames.actorDetails, arguments: id);
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