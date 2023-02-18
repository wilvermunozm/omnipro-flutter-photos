import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/faillure.dart';
import '../../../../core/providers/url_provider.dart';
import '../model/photo_model.dart';

abstract class PhotoRepositoryDataSource {
  Future<List<PhotoModel>> getPhotos();
}

class PhotoDataSource implements PhotoRepositoryDataSource {
  final http.Client httpClient;
  final UrlProvider urlProvider;

  PhotoDataSource({required this.httpClient, required this.urlProvider});

  @override
  Future<List<PhotoModel>> getPhotos() async {
    Uri uri = urlProvider.getUrl('/photos', {});

    var response = await httpClient.get(uri, headers: {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*',
    });
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);

      final jsonListPhotos = List.from(decodedJson);
      return jsonListPhotos.map((photoJson) => PhotoModel.fromJson(photoJson)).toList();
    } else {
      throw ServerFailure('Something went wrong while requesting photo list');
    }
  }
}
