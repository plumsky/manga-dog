import 'package:freezed_annotation/freezed_annotation.dart';

part 'manga_entity.freezed.dart';
part 'manga_entity.g.dart';

@freezed
abstract class MangaEntity with _$MangaEntity {
  const factory MangaEntity({
    required String id,
    required String title,
    String? coverPath,
    String? folderPath,
    int? totalPages,
    int? currentPage,
    double? readingProgress,
    DateTime? lastReadAt,
    List<String>? tags,
    bool? isFavorite,
    String? description,
    String? author,
  }) = _MangaEntity;

  factory MangaEntity.fromJson(Map<String, dynamic> json) =>
      _$MangaEntityFromJson(json);
}
