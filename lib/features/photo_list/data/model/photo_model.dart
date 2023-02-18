import '../../domain/entities/photo.dart';

class PhotoModel extends Photo {
  const PhotoModel({
    required super.id,
    required super.title,
    required super.url,
    required super.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> photoJson) {
    return PhotoModel(
      id: photoJson['id'],
      title: photoJson['title'],
      url: photoJson['url'],
      thumbnailUrl: photoJson['thumbnailUrl'],
    );
  }
}
