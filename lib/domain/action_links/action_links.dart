import 'package:url_launcher/url_launcher.dart';

abstract class LinkKeys {
  static const String instaUrl = 'https://instagram.com';
  static const String facebookUrl = 'https://www.facebook.com';
  static const String twitterUrl = 'https://twitter.com';
}

Future<void> onLaunchUrl({String? uri, String? linkKey}) async {
  if(uri == null && linkKey == null) return;
  final Uri _url = Uri.parse('$uri/$linkKey');
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}