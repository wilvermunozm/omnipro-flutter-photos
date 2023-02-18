import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:omnipro/features/photo_list/data/model/photo_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('Photo Model: ', () {
    PhotoModel tPhotoModel = const PhotoModel(
      id: 1,
      title: "title",
      url: "url",
      thumbnailUrl: "thumbnailUrl",
    );

    testWidgets('Should be a photoModel', (tester) async {
      expect(tPhotoModel, isA<PhotoModel>());
    });

    testWidgets('Should parse a photo from a json response', (tester) async {
      //Arrange
      final Map<String, dynamic> decoded = json.decode(fixture('photo/photo_fixture.json'));
      //Act
      var result = PhotoModel.fromJson(decoded);
      //Assert
      expect(result, equals(tPhotoModel));
    });

    testWidgets('Should parse all photo fields from a json response', (tester) async {
      //Arrange
      final Map<String, dynamic> decoded = json.decode(fixture('photo/photo_fixture.json'));
      //Act
      var result = PhotoModel.fromJson(decoded);
      //Assert
      expect(result.id, equals(tPhotoModel.id));
      expect(result.title, equals(tPhotoModel.title));
      expect(result.url, equals('url'));
      expect(result.thumbnailUrl, equals(tPhotoModel.thumbnailUrl));
    });
  });
}
