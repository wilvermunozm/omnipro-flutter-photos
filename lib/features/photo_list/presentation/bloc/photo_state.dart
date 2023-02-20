// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  final List<Photo> photos;

  const PhotoState(
    this.photos,
  );

  @override
  List<Object> get props => [];
}

class Initial extends PhotoState {
  Initial() : super(List.empty());
}

class Loading extends PhotoState {
  Loading() : super(List.empty());
}

class Loaded extends PhotoState {
  final List<Photo> photoList;
  final List<Photo> photoListInView;
  final int page;

  const Loaded(
    this.photoList,
    this.photoListInView,
    this.page,
  ) : super(photoList);

  @override
  List<Object> get props => [photoList, photoListInView, page];
}

class Error extends PhotoState {
  final String errorMessage;

  Error({required this.errorMessage}) : super(List.empty());
}
