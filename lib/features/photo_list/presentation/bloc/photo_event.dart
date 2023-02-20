import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}

class GetPhotosEvent extends PhotoEvent {
  const GetPhotosEvent() : super();
}

class MoreResultsEvent extends PhotoEvent {
  const MoreResultsEvent() : super();
}
