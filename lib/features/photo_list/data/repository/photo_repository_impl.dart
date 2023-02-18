import 'package:dartz/dartz.dart';
import 'package:omnipro/features/photo_list/domain/entities/photo.dart';

import '../../../../core/error/faillure.dart';
import '../../domain/repository/photo_repository.dart';
import '../data_source/photo_data_source.dart';

class PhotoRepositoryImpl extends PhotoRepository {
  final PhotoDataSource photoDataSource;

  PhotoRepositoryImpl({required this.photoDataSource});

  @override
  Future<Either<Failure, List<Photo>>> getPhotos() async {
    try {
      var result = await photoDataSource.getPhotos();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure('Server error while sending the request: $e'));
    } catch (e) {
      return Left(ServerFailure('Server error while sending the request'));
    }
  }


}
