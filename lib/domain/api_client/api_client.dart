import 'dart:convert';
import 'dart:io';
import 'package:movies_mobile/domain/entity/movie_details.dart';
import 'package:movies_mobile/domain/entity/popular_movie_response.dart';

enum ApiClientExceptionType { network, auth, other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3/';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  static const _apiKey = '6da038d6c5eaeb50367914a0174dce16';

  static String imageUrl(String? path) => path != null ? _imageUrl + path: '';

  Uri makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = await response.jsonDecode();
      _validateResponse(response, json);
      final result = parser(json);

      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> _post<T>(
    String path,
    Map<String, dynamic>? bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = makeUri(path, urlParameters);
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));

      final response = await request.close();
      final dynamic json = await response.jsonDecode();
      _validateResponse(response, json);
      final token = parser(json);
      return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<String> auth(
      {required String username, required String password}) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
        username: username, password: password, requestToken: token);
    final sessionId = await _makeSession(requestToken: validToken);

    return sessionId;
  }

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = await _get('authentication/token/new', parser,
        <String, dynamic>{'api_key': _apiKey});
    return result;
  }

  Future<PopularMovieResponse> popularMovie(int page, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = await _get('movie/popular', parser, <String, dynamic>{
      'api_key': _apiKey,
      'page': page.toString(),
      'language': locale
    });

    return result;
  }

  Future<PopularMovieResponse> searchMovie(
      int page, String locale, String query) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = await _get('search/movie', parser, <String, dynamic>{
      'api_key': _apiKey,
      'query': query,
      'page': page.toString(),
      'language': locale,
      'include_adult': true.toString()
    });

    return result;
  }

  Future<MovieDetails> movieDetails(int movieId, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);

      return response;
    }

    final result = await _get(
      'movie/$movieId',
      parser,
      <String, dynamic>{
        'api_key': _apiKey,
        'language': locale,
        'append_to_response': 'credits'
      },
    );

    return result;
  }

  Future<String> _validateUser(
      {required String username,
      required String password,
      required String requestToken}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final parameters = <String, dynamic>{
      "username": username,
      "password": password,
      "request_token": requestToken
    };

    final result = await _post(
      'authentication/token/validate_with_login',
      parameters,
      parser,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  Future<String> _makeSession({required String requestToken}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    }

    final parameters = <String, dynamic>{"request_token": requestToken};
    final result = await _post('authentication/session/new', parameters, parser,
        <String, dynamic>{'api_key': _apiKey});
    return result;
  }
}

void _validateResponse(HttpClientResponse response, dynamic json) {
  if (response.statusCode == 401) {
    final dynamic status = json['status_code'];
    final code = status is int ? status : 0;
    if (code == 30) {
      throw ApiClientException(ApiClientExceptionType.auth);
    } else {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((value) => json.decode(value));
  }
}
