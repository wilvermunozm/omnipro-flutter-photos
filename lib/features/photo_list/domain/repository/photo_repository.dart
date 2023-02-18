import 'package:dartz/dartz.dart';

import '../../../../core/error/faillure.dart';
import '../entities/photo.dart';

abstract class PhotoRepository {
  Future<Either<Failure, List<Photo>>> getPhotos();
}
