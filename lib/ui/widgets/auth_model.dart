import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_mobile/domain/api_client/api_client.dart';
import 'package:movies_mobile/domain/data_provider/session_data_provider.dart';
import 'package:movies_mobile/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _sessionDataProvider = SessionDataProvider();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if(login.isEmpty || password.isEmpty) {
      _errorMessage = 'You should field login or password';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    int? accountId;
    try {
      sessionId = await _apiClient.auth(username: login, password: password);
      accountId = await _apiClient.getAccountInfo(sessionId);
    } on ApiClientException catch(e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage = 'Server is not available. Check your internet connection';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Login or password is wrong';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'Something went wrong. Please try again';
          break;
        case ApiClientExceptionType.sessionExpired:
          _errorMessage = 'Something went wrong. Please try again';
          break;
        default:
          print('\x1B[33m${ e }\x1B[0m');
      }
    }

    _isAuthProgress = false;
    if(_errorMessage != null) {
      notifyListeners();
      return;
    }
    if(sessionId == null || accountId == null) {
      _errorMessage = 'Something went wrong';
      notifyListeners();
      return;
    }

   await _sessionDataProvider.setSessionId(sessionId);
   await _sessionDataProvider.setAccountId(accountId);
    unawaited(Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.mainScreen));
  }
}
