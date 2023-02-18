// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final String id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [id];
}
