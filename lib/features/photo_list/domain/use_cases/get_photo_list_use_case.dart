import 'package:dartz/dartz.dart';

import '../../../../core/error/faillure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/photo.dart';
import '../repository/photo_repository.dart';

class GetPhotoListUseCase implements UseCase<List<Photo>, NoParams> {
  final PhotoRepository photoRepository;

  GetPhotoListUseCase({required this.photoRepository});

  @override
  Future<Either<Failure, List<Photo>>> call(NoParams params) {
    return photoRepository.getPhotos();
  }
}
