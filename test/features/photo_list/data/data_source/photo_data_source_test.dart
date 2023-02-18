import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:omnipro/core/error/faillure.dart';
import 'package:omnipro/core/providers/url_provider.dart';
import 'package:omnipro/features/photo_list/data/data_source/photo_data_source.dart';
import 'package:omnipro/features/photo_list/data/model/photo_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'photo_data_source_test.mocks.dart';

@GenerateMocks([http.Client, UrlProvider])
void main() {
  MockUrlProvider mockUrlProvider = MockUrlProvider();
  MockClient mockClient = MockClient();
  PhotoDataSource photoDataSource = PhotoDataSource(httpClient: mockClient, urlProvider: mockUrlProvider);
  final tPhotoListResponse = json.decode(fixture('photo/photo_list_fixture.json'));

  List<PhotoModel> _getList() {
    List<PhotoModel> photoList = <PhotoModel>[];
    for (Map<String, dynamic> item in tPhotoListResponse) {
      var photo = PhotoModel.fromJson(item);
      photoList.add(photo);
    }
    return photoList;
  }

  void setUpHttpCallSuccess200() {
    final uri = UrlProvider().getUrl('/photos', {});
    when(mockClient.get(uri, headers: {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*',
    })).thenAnswer((_) async => Future.value(http.Response(fixture('photo/photo_list_fixture.json'), 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        })));
    when(mockUrlProvider.getUrl(any, any)).thenAnswer((realInvocation) => uri);
  }

  group('Http configuration: ', () {
    testWidgets('should perform a get request for a photo list with application/json header', (tester) async {
      //Arrange
      setUpHttpCallSuccess200();

      //Act
      await photoDataSource.getPhotos();
      //Assert
      verify(mockClient.get(any, headers: {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': '*/*',
        'Access-Control-Allow-Origin': '*',
      }));
    });
  });

  group('PhotoDataSourceImpl: ', () {
    testWidgets('should get a list of photos when requesting data to the API', (tester) async {
      //Arrange
      setUpHttpCallSuccess200();
      //Act
      var result = await photoDataSource.getPhotos();
      //Assert
      expect(result, equals(_getList()));
    });

    test('Should throw a serverException when the respond is 404 or other when getting a list of photos', () async {
      //Arrange
      final uri = UrlProvider().getUrl('/photos', {});
      when(mockUrlProvider.getUrl(any, any)).thenAnswer((realInvocation) => uri);

      when(mockClient.get(uri, headers: anyNamed('headers'))).thenAnswer(
        (realInvocation) async => http.Response('Something went wrong while getting clients', 404),
      );
      //Act
      final call = photoDataSource.getPhotos();
      //Assert
      expect(() => call, throwsA(const TypeMatcher<ServerFailure>()));
    });
  });
}
