import '../config/constants/access.dart';

class UrlProvider {
  Uri getUrl(String path, Map<String, dynamic>? params) {
    String environmentUrl = _getUrl();

    if (params == null) {
      return Uri.https(environmentUrl, path);
    } else {
      return Uri.https(environmentUrl, path, params);
    }
  }

  String _getUrl() => serverUrl;
}
