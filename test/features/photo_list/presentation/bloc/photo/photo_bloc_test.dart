import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:omnipro/core/error/faillure.dart';
import 'package:omnipro/core/use_cases/use_case.dart';
import 'package:omnipro/features/photo_list/domain/entities/photo.dart';
import 'package:omnipro/features/photo_list/domain/use_cases/get_photo_list_use_case.dart';
import 'package:omnipro/features/photo_list/presentation/bloc/photo_bloc.dart';
import 'package:omnipro/features/photo_list/presentation/bloc/photo_event.dart';

import 'photo_bloc_test.mocks.dart';

@GenerateMocks([GetPhotoListUseCase])
void main() {
  MockGetPhotoUseCase mockGetPhotoUseCase = MockGetPhotoUseCase();
  late PhotoBloc bloc = PhotoBloc(getPhotoListUseCase: mockGetPhotoUseCase);

  List<Photo> tPhotoData = <Photo>[
    const Photo(id: 1, title: "title", url: "url", thumbnailUrl: "thumbnailUrl"),
  ];
  group('Photo bloc: ', () {
    setUp(() {
      bloc.close();
      bloc = PhotoBloc(getPhotoListUseCase: mockGetPhotoUseCase);
    });

    blocTest('emits [] when nothing is added', build: () => bloc, expect: () => [], wait: const Duration(milliseconds: 500));

    blocTest<PhotoBloc, PhotoState>('emits [Loading, Loaded] when getting photos list.',
        setUp: () => when(mockGetPhotoUseCase.call(NoParams())).thenAnswer((realInvocation) async => Future.value(Right(tPhotoData))),
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(const GetPhotosEvent()),
        expect: () => <PhotoState>[Loading(), Loaded(tPhotoData, tPhotoData, 0)],
        tearDown: bloc.close,
        wait: const Duration(milliseconds: 500));

    blocTest<PhotoBloc, PhotoState>('emits [Loading, Error] when getting my watchlists fails.',
        setUp: () =>
            when(mockGetPhotoUseCase.call(NoParams())).thenAnswer((realInvocation) async => Future.value(Left(ServerFailure(serverException)))),
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(const GetPhotosEvent()),
        expect: () => <PhotoState>[Loading(), Error(errorMessage: serverException)],
        wait: const Duration(milliseconds: 500));
  });
}
