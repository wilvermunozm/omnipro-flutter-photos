import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omnipro/features/photo_list/domain/use_cases/get_photo_list_use_case.dart';
import 'package:omnipro/features/photo_list/presentation/bloc/photo_event.dart';

import '../../../../core/config/constants/params.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../domain/entities/photo.dart';

part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotoListUseCase getPhotoListUseCase;

  PhotoBloc({required this.getPhotoListUseCase}) : super(Initial()) {
    on<PhotoEvent>((event, emit) async {
      if (event is GetPhotosEvent) {
        emit(Loading());
        final result = await getPhotoListUseCase.call(NoParams());
        result.fold(
          (left) => emit(Error(errorMessage: left.toString())),
          (right) {
            emit(Loaded(
              right,
              right.length > kMaxPhotosPerPage ? right.sublist(0, kMaxPhotosPerPage) : right,
              state is Loaded ? (state as Loaded).page + 1 : 0,
            ));
          },
        );
      }

      if (event is MoreResultsEvent) {
        if (state is Loaded) {
          final loadedState = state as Loaded;
          final newPageNumber = loadedState.page + 1;
          final newPhotoList = loadedState.photoListInView;
          final maxIndexToLoad = newPageNumber * kMaxPhotosPerPage;
          newPhotoList.addAll(loadedState.photoList.sublist(maxIndexToLoad - kMaxPhotosPerPage, maxIndexToLoad));
          emit(Loaded(loadedState.photoList, List.from(newPhotoList), newPageNumber));
        }
      }
    });
  }
}
