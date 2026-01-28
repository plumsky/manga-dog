// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MangaEntity _$MangaEntityFromJson(Map<String, dynamic> json) => _MangaEntity(
  id: json['id'] as String,
  title: json['title'] as String,
  coverPath: json['coverPath'] as String?,
  folderPath: json['folderPath'] as String?,
  totalPages: (json['totalPages'] as num?)?.toInt(),
  currentPage: (json['currentPage'] as num?)?.toInt(),
  readingProgress: (json['readingProgress'] as num?)?.toDouble(),
  lastReadAt: json['lastReadAt'] == null
      ? null
      : DateTime.parse(json['lastReadAt'] as String),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  isFavorite: json['isFavorite'] as bool?,
  description: json['description'] as String?,
  author: json['author'] as String?,
);

Map<String, dynamic> _$MangaEntityToJson(_MangaEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'coverPath': instance.coverPath,
      'folderPath': instance.folderPath,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'readingProgress': instance.readingProgress,
      'lastReadAt': instance.lastReadAt?.toIso8601String(),
      'tags': instance.tags,
      'isFavorite': instance.isFavorite,
      'description': instance.description,
      'author': instance.author,
    };
