import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:omnipro/core/error/faillure.dart';
import 'package:omnipro/features/photo_list/data/data_source/photo_data_source.dart';
import 'package:omnipro/features/photo_list/data/model/photo_model.dart';
import 'package:omnipro/features/photo_list/data/repository/photo_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'photo_repository_impl_test.mocks.dart';

@GenerateMocks([PhotoDataSource])
void main() {
  MockPhotoDataSource mockPhotoDataSource = MockPhotoDataSource();
  PhotoRepositoryImpl photoRepositoryImpl = PhotoRepositoryImpl(photoDataSource: mockPhotoDataSource);
  final tPhotoResponse = json.decode(fixture('photo/photo_fixture.json'));
  group('PhotoRepositoryImpl: ', () {
    testWidgets('Should get a photo list', (tester) async {
      //ARRANGE
      List<PhotoModel> photoList = <PhotoModel>[];
      photoList.add(PhotoModel.fromJson(tPhotoResponse));

      when(mockPhotoDataSource.getPhotos()).thenAnswer((realInvocation) => Future.value((photoList)));

      //ACT
      var result = await photoRepositoryImpl.getPhotos();

      //ASSERT
      verify(mockPhotoDataSource.getPhotos());
      expect(true, result.isRight());
    });

    testWidgets('Should get a list of photos but gets a failure', (tester) async {
      //ARRANGE
      when(mockPhotoDataSource.getPhotos()).thenThrow((realInvocation) async => Future.value(ServerFailure('Error Message')));
      //ACT
      var result = await photoRepositoryImpl.getPhotos();
      //ASSERT
      verify(mockPhotoDataSource.getPhotos());
      expect(true, result.isLeft());
    });
  });
}
