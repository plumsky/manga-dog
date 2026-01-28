// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MangaEntity {

 String get id; String get title; String? get coverPath; String? get folderPath; int? get totalPages; int? get currentPage; double? get readingProgress; DateTime? get lastReadAt; List<String>? get tags; bool? get isFavorite; String? get description; String? get author;
/// Create a copy of MangaEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MangaEntityCopyWith<MangaEntity> get copyWith => _$MangaEntityCopyWithImpl<MangaEntity>(this as MangaEntity, _$identity);

  /// Serializes this MangaEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MangaEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.coverPath, coverPath) || other.coverPath == coverPath)&&(identical(other.folderPath, folderPath) || other.folderPath == folderPath)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.readingProgress, readingProgress) || other.readingProgress == readingProgress)&&(identical(other.lastReadAt, lastReadAt) || other.lastReadAt == lastReadAt)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,coverPath,folderPath,totalPages,currentPage,readingProgress,lastReadAt,const DeepCollectionEquality().hash(tags),isFavorite,description,author);

@override
String toString() {
  return 'MangaEntity(id: $id, title: $title, coverPath: $coverPath, folderPath: $folderPath, totalPages: $totalPages, currentPage: $currentPage, readingProgress: $readingProgress, lastReadAt: $lastReadAt, tags: $tags, isFavorite: $isFavorite, description: $description, author: $author)';
}


}

/// @nodoc
abstract mixin class $MangaEntityCopyWith<$Res>  {
  factory $MangaEntityCopyWith(MangaEntity value, $Res Function(MangaEntity) _then) = _$MangaEntityCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? coverPath, String? folderPath, int? totalPages, int? currentPage, double? readingProgress, DateTime? lastReadAt, List<String>? tags, bool? isFavorite, String? description, String? author
});




}
/// @nodoc
class _$MangaEntityCopyWithImpl<$Res>
    implements $MangaEntityCopyWith<$Res> {
  _$MangaEntityCopyWithImpl(this._self, this._then);

  final MangaEntity _self;
  final $Res Function(MangaEntity) _then;

/// Create a copy of MangaEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? coverPath = freezed,Object? folderPath = freezed,Object? totalPages = freezed,Object? currentPage = freezed,Object? readingProgress = freezed,Object? lastReadAt = freezed,Object? tags = freezed,Object? isFavorite = freezed,Object? description = freezed,Object? author = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,coverPath: freezed == coverPath ? _self.coverPath : coverPath // ignore: cast_nullable_to_non_nullable
as String?,folderPath: freezed == folderPath ? _self.folderPath : folderPath // ignore: cast_nullable_to_non_nullable
as String?,totalPages: freezed == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int?,currentPage: freezed == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int?,readingProgress: freezed == readingProgress ? _self.readingProgress : readingProgress // ignore: cast_nullable_to_non_nullable
as double?,lastReadAt: freezed == lastReadAt ? _self.lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,isFavorite: freezed == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MangaEntity].
extension MangaEntityPatterns on MangaEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MangaEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MangaEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MangaEntity value)  $default,){
final _that = this;
switch (_that) {
case _MangaEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MangaEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MangaEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? coverPath,  String? folderPath,  int? totalPages,  int? currentPage,  double? readingProgress,  DateTime? lastReadAt,  List<String>? tags,  bool? isFavorite,  String? description,  String? author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MangaEntity() when $default != null:
return $default(_that.id,_that.title,_that.coverPath,_that.folderPath,_that.totalPages,_that.currentPage,_that.readingProgress,_that.lastReadAt,_that.tags,_that.isFavorite,_that.description,_that.author);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? coverPath,  String? folderPath,  int? totalPages,  int? currentPage,  double? readingProgress,  DateTime? lastReadAt,  List<String>? tags,  bool? isFavorite,  String? description,  String? author)  $default,) {final _that = this;
switch (_that) {
case _MangaEntity():
return $default(_that.id,_that.title,_that.coverPath,_that.folderPath,_that.totalPages,_that.currentPage,_that.readingProgress,_that.lastReadAt,_that.tags,_that.isFavorite,_that.description,_that.author);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? coverPath,  String? folderPath,  int? totalPages,  int? currentPage,  double? readingProgress,  DateTime? lastReadAt,  List<String>? tags,  bool? isFavorite,  String? description,  String? author)?  $default,) {final _that = this;
switch (_that) {
case _MangaEntity() when $default != null:
return $default(_that.id,_that.title,_that.coverPath,_that.folderPath,_that.totalPages,_that.currentPage,_that.readingProgress,_that.lastReadAt,_that.tags,_that.isFavorite,_that.description,_that.author);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MangaEntity implements MangaEntity {
  const _MangaEntity({required this.id, required this.title, this.coverPath, this.folderPath, this.totalPages, this.currentPage, this.readingProgress, this.lastReadAt, final  List<String>? tags, this.isFavorite, this.description, this.author}): _tags = tags;
  factory _MangaEntity.fromJson(Map<String, dynamic> json) => _$MangaEntityFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? coverPath;
@override final  String? folderPath;
@override final  int? totalPages;
@override final  int? currentPage;
@override final  double? readingProgress;
@override final  DateTime? lastReadAt;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? isFavorite;
@override final  String? description;
@override final  String? author;

/// Create a copy of MangaEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MangaEntityCopyWith<_MangaEntity> get copyWith => __$MangaEntityCopyWithImpl<_MangaEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MangaEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MangaEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.coverPath, coverPath) || other.coverPath == coverPath)&&(identical(other.folderPath, folderPath) || other.folderPath == folderPath)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.readingProgress, readingProgress) || other.readingProgress == readingProgress)&&(identical(other.lastReadAt, lastReadAt) || other.lastReadAt == lastReadAt)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,coverPath,folderPath,totalPages,currentPage,readingProgress,lastReadAt,const DeepCollectionEquality().hash(_tags),isFavorite,description,author);

@override
String toString() {
  return 'MangaEntity(id: $id, title: $title, coverPath: $coverPath, folderPath: $folderPath, totalPages: $totalPages, currentPage: $currentPage, readingProgress: $readingProgress, lastReadAt: $lastReadAt, tags: $tags, isFavorite: $isFavorite, description: $description, author: $author)';
}


}

/// @nodoc
abstract mixin class _$MangaEntityCopyWith<$Res> implements $MangaEntityCopyWith<$Res> {
  factory _$MangaEntityCopyWith(_MangaEntity value, $Res Function(_MangaEntity) _then) = __$MangaEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? coverPath, String? folderPath, int? totalPages, int? currentPage, double? readingProgress, DateTime? lastReadAt, List<String>? tags, bool? isFavorite, String? description, String? author
});




}
/// @nodoc
class __$MangaEntityCopyWithImpl<$Res>
    implements _$MangaEntityCopyWith<$Res> {
  __$MangaEntityCopyWithImpl(this._self, this._then);

  final _MangaEntity _self;
  final $Res Function(_MangaEntity) _then;

/// Create a copy of MangaEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? coverPath = freezed,Object? folderPath = freezed,Object? totalPages = freezed,Object? currentPage = freezed,Object? readingProgress = freezed,Object? lastReadAt = freezed,Object? tags = freezed,Object? isFavorite = freezed,Object? description = freezed,Object? author = freezed,}) {
  return _then(_MangaEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,coverPath: freezed == coverPath ? _self.coverPath : coverPath // ignore: cast_nullable_to_non_nullable
as String?,folderPath: freezed == folderPath ? _self.folderPath : folderPath // ignore: cast_nullable_to_non_nullable
as String?,totalPages: freezed == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int?,currentPage: freezed == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int?,readingProgress: freezed == readingProgress ? _self.readingProgress : readingProgress // ignore: cast_nullable_to_non_nullable
as double?,lastReadAt: freezed == lastReadAt ? _self.lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,isFavorite: freezed == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
