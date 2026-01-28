// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppConfig {

 ThemeMode get themeMode; String get language; bool get firstLaunch; ReaderViewMode get viewMode; ZoomMode get zoomMode; bool get autoHideControls; bool get enablePageTurnAnimation; String get sourceLanguage; String get targetLanguage; String get translationEngine; bool get enableAutoTranslate; bool get enableOCR; TranslationFontStyle get fontStyle; int get fontSize; String get fontColor; double get windowWidth; double get windowHeight; bool get isMaximized; String? get lastOpenedFolder; List<String> get recentFolders;
/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigCopyWith<AppConfig> get copyWith => _$AppConfigCopyWithImpl<AppConfig>(this as AppConfig, _$identity);

  /// Serializes this AppConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfig&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.language, language) || other.language == language)&&(identical(other.firstLaunch, firstLaunch) || other.firstLaunch == firstLaunch)&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode)&&(identical(other.zoomMode, zoomMode) || other.zoomMode == zoomMode)&&(identical(other.autoHideControls, autoHideControls) || other.autoHideControls == autoHideControls)&&(identical(other.enablePageTurnAnimation, enablePageTurnAnimation) || other.enablePageTurnAnimation == enablePageTurnAnimation)&&(identical(other.sourceLanguage, sourceLanguage) || other.sourceLanguage == sourceLanguage)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.translationEngine, translationEngine) || other.translationEngine == translationEngine)&&(identical(other.enableAutoTranslate, enableAutoTranslate) || other.enableAutoTranslate == enableAutoTranslate)&&(identical(other.enableOCR, enableOCR) || other.enableOCR == enableOCR)&&(identical(other.fontStyle, fontStyle) || other.fontStyle == fontStyle)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.fontColor, fontColor) || other.fontColor == fontColor)&&(identical(other.windowWidth, windowWidth) || other.windowWidth == windowWidth)&&(identical(other.windowHeight, windowHeight) || other.windowHeight == windowHeight)&&(identical(other.isMaximized, isMaximized) || other.isMaximized == isMaximized)&&(identical(other.lastOpenedFolder, lastOpenedFolder) || other.lastOpenedFolder == lastOpenedFolder)&&const DeepCollectionEquality().equals(other.recentFolders, recentFolders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,themeMode,language,firstLaunch,viewMode,zoomMode,autoHideControls,enablePageTurnAnimation,sourceLanguage,targetLanguage,translationEngine,enableAutoTranslate,enableOCR,fontStyle,fontSize,fontColor,windowWidth,windowHeight,isMaximized,lastOpenedFolder,const DeepCollectionEquality().hash(recentFolders)]);

@override
String toString() {
  return 'AppConfig(themeMode: $themeMode, language: $language, firstLaunch: $firstLaunch, viewMode: $viewMode, zoomMode: $zoomMode, autoHideControls: $autoHideControls, enablePageTurnAnimation: $enablePageTurnAnimation, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, translationEngine: $translationEngine, enableAutoTranslate: $enableAutoTranslate, enableOCR: $enableOCR, fontStyle: $fontStyle, fontSize: $fontSize, fontColor: $fontColor, windowWidth: $windowWidth, windowHeight: $windowHeight, isMaximized: $isMaximized, lastOpenedFolder: $lastOpenedFolder, recentFolders: $recentFolders)';
}


}

/// @nodoc
abstract mixin class $AppConfigCopyWith<$Res>  {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) _then) = _$AppConfigCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode, String language, bool firstLaunch, ReaderViewMode viewMode, ZoomMode zoomMode, bool autoHideControls, bool enablePageTurnAnimation, String sourceLanguage, String targetLanguage, String translationEngine, bool enableAutoTranslate, bool enableOCR, TranslationFontStyle fontStyle, int fontSize, String fontColor, double windowWidth, double windowHeight, bool isMaximized, String? lastOpenedFolder, List<String> recentFolders
});




}
/// @nodoc
class _$AppConfigCopyWithImpl<$Res>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._self, this._then);

  final AppConfig _self;
  final $Res Function(AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? language = null,Object? firstLaunch = null,Object? viewMode = null,Object? zoomMode = null,Object? autoHideControls = null,Object? enablePageTurnAnimation = null,Object? sourceLanguage = null,Object? targetLanguage = null,Object? translationEngine = null,Object? enableAutoTranslate = null,Object? enableOCR = null,Object? fontStyle = null,Object? fontSize = null,Object? fontColor = null,Object? windowWidth = null,Object? windowHeight = null,Object? isMaximized = null,Object? lastOpenedFolder = freezed,Object? recentFolders = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,firstLaunch: null == firstLaunch ? _self.firstLaunch : firstLaunch // ignore: cast_nullable_to_non_nullable
as bool,viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as ReaderViewMode,zoomMode: null == zoomMode ? _self.zoomMode : zoomMode // ignore: cast_nullable_to_non_nullable
as ZoomMode,autoHideControls: null == autoHideControls ? _self.autoHideControls : autoHideControls // ignore: cast_nullable_to_non_nullable
as bool,enablePageTurnAnimation: null == enablePageTurnAnimation ? _self.enablePageTurnAnimation : enablePageTurnAnimation // ignore: cast_nullable_to_non_nullable
as bool,sourceLanguage: null == sourceLanguage ? _self.sourceLanguage : sourceLanguage // ignore: cast_nullable_to_non_nullable
as String,targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as String,translationEngine: null == translationEngine ? _self.translationEngine : translationEngine // ignore: cast_nullable_to_non_nullable
as String,enableAutoTranslate: null == enableAutoTranslate ? _self.enableAutoTranslate : enableAutoTranslate // ignore: cast_nullable_to_non_nullable
as bool,enableOCR: null == enableOCR ? _self.enableOCR : enableOCR // ignore: cast_nullable_to_non_nullable
as bool,fontStyle: null == fontStyle ? _self.fontStyle : fontStyle // ignore: cast_nullable_to_non_nullable
as TranslationFontStyle,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as int,fontColor: null == fontColor ? _self.fontColor : fontColor // ignore: cast_nullable_to_non_nullable
as String,windowWidth: null == windowWidth ? _self.windowWidth : windowWidth // ignore: cast_nullable_to_non_nullable
as double,windowHeight: null == windowHeight ? _self.windowHeight : windowHeight // ignore: cast_nullable_to_non_nullable
as double,isMaximized: null == isMaximized ? _self.isMaximized : isMaximized // ignore: cast_nullable_to_non_nullable
as bool,lastOpenedFolder: freezed == lastOpenedFolder ? _self.lastOpenedFolder : lastOpenedFolder // ignore: cast_nullable_to_non_nullable
as String?,recentFolders: null == recentFolders ? _self.recentFolders : recentFolders // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfig].
extension AppConfigPatterns on AppConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppConfig value)  $default,){
final _that = this;
switch (_that) {
case _AppConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode themeMode,  String language,  bool firstLaunch,  ReaderViewMode viewMode,  ZoomMode zoomMode,  bool autoHideControls,  bool enablePageTurnAnimation,  String sourceLanguage,  String targetLanguage,  String translationEngine,  bool enableAutoTranslate,  bool enableOCR,  TranslationFontStyle fontStyle,  int fontSize,  String fontColor,  double windowWidth,  double windowHeight,  bool isMaximized,  String? lastOpenedFolder,  List<String> recentFolders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.themeMode,_that.language,_that.firstLaunch,_that.viewMode,_that.zoomMode,_that.autoHideControls,_that.enablePageTurnAnimation,_that.sourceLanguage,_that.targetLanguage,_that.translationEngine,_that.enableAutoTranslate,_that.enableOCR,_that.fontStyle,_that.fontSize,_that.fontColor,_that.windowWidth,_that.windowHeight,_that.isMaximized,_that.lastOpenedFolder,_that.recentFolders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode themeMode,  String language,  bool firstLaunch,  ReaderViewMode viewMode,  ZoomMode zoomMode,  bool autoHideControls,  bool enablePageTurnAnimation,  String sourceLanguage,  String targetLanguage,  String translationEngine,  bool enableAutoTranslate,  bool enableOCR,  TranslationFontStyle fontStyle,  int fontSize,  String fontColor,  double windowWidth,  double windowHeight,  bool isMaximized,  String? lastOpenedFolder,  List<String> recentFolders)  $default,) {final _that = this;
switch (_that) {
case _AppConfig():
return $default(_that.themeMode,_that.language,_that.firstLaunch,_that.viewMode,_that.zoomMode,_that.autoHideControls,_that.enablePageTurnAnimation,_that.sourceLanguage,_that.targetLanguage,_that.translationEngine,_that.enableAutoTranslate,_that.enableOCR,_that.fontStyle,_that.fontSize,_that.fontColor,_that.windowWidth,_that.windowHeight,_that.isMaximized,_that.lastOpenedFolder,_that.recentFolders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode themeMode,  String language,  bool firstLaunch,  ReaderViewMode viewMode,  ZoomMode zoomMode,  bool autoHideControls,  bool enablePageTurnAnimation,  String sourceLanguage,  String targetLanguage,  String translationEngine,  bool enableAutoTranslate,  bool enableOCR,  TranslationFontStyle fontStyle,  int fontSize,  String fontColor,  double windowWidth,  double windowHeight,  bool isMaximized,  String? lastOpenedFolder,  List<String> recentFolders)?  $default,) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.themeMode,_that.language,_that.firstLaunch,_that.viewMode,_that.zoomMode,_that.autoHideControls,_that.enablePageTurnAnimation,_that.sourceLanguage,_that.targetLanguage,_that.translationEngine,_that.enableAutoTranslate,_that.enableOCR,_that.fontStyle,_that.fontSize,_that.fontColor,_that.windowWidth,_that.windowHeight,_that.isMaximized,_that.lastOpenedFolder,_that.recentFolders);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppConfig implements AppConfig {
  const _AppConfig({this.themeMode = ThemeMode.system, this.language = 'zh-CN', this.firstLaunch = true, this.viewMode = ReaderViewMode.single, this.zoomMode = ZoomMode.fitWidth, this.autoHideControls = true, this.enablePageTurnAnimation = true, this.sourceLanguage = 'auto', this.targetLanguage = 'zh-CN', this.translationEngine = 'google', this.enableAutoTranslate = false, this.enableOCR = true, this.fontStyle = TranslationFontStyle.comic, this.fontSize = 16, this.fontColor = '#000000', this.windowWidth = 1280.0, this.windowHeight = 720.0, this.isMaximized = false, this.lastOpenedFolder, final  List<String> recentFolders = const []}): _recentFolders = recentFolders;
  factory _AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);

@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  String language;
@override@JsonKey() final  bool firstLaunch;
@override@JsonKey() final  ReaderViewMode viewMode;
@override@JsonKey() final  ZoomMode zoomMode;
@override@JsonKey() final  bool autoHideControls;
@override@JsonKey() final  bool enablePageTurnAnimation;
@override@JsonKey() final  String sourceLanguage;
@override@JsonKey() final  String targetLanguage;
@override@JsonKey() final  String translationEngine;
@override@JsonKey() final  bool enableAutoTranslate;
@override@JsonKey() final  bool enableOCR;
@override@JsonKey() final  TranslationFontStyle fontStyle;
@override@JsonKey() final  int fontSize;
@override@JsonKey() final  String fontColor;
@override@JsonKey() final  double windowWidth;
@override@JsonKey() final  double windowHeight;
@override@JsonKey() final  bool isMaximized;
@override final  String? lastOpenedFolder;
 final  List<String> _recentFolders;
@override@JsonKey() List<String> get recentFolders {
  if (_recentFolders is EqualUnmodifiableListView) return _recentFolders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentFolders);
}


/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppConfigCopyWith<_AppConfig> get copyWith => __$AppConfigCopyWithImpl<_AppConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppConfig&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.language, language) || other.language == language)&&(identical(other.firstLaunch, firstLaunch) || other.firstLaunch == firstLaunch)&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode)&&(identical(other.zoomMode, zoomMode) || other.zoomMode == zoomMode)&&(identical(other.autoHideControls, autoHideControls) || other.autoHideControls == autoHideControls)&&(identical(other.enablePageTurnAnimation, enablePageTurnAnimation) || other.enablePageTurnAnimation == enablePageTurnAnimation)&&(identical(other.sourceLanguage, sourceLanguage) || other.sourceLanguage == sourceLanguage)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.translationEngine, translationEngine) || other.translationEngine == translationEngine)&&(identical(other.enableAutoTranslate, enableAutoTranslate) || other.enableAutoTranslate == enableAutoTranslate)&&(identical(other.enableOCR, enableOCR) || other.enableOCR == enableOCR)&&(identical(other.fontStyle, fontStyle) || other.fontStyle == fontStyle)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.fontColor, fontColor) || other.fontColor == fontColor)&&(identical(other.windowWidth, windowWidth) || other.windowWidth == windowWidth)&&(identical(other.windowHeight, windowHeight) || other.windowHeight == windowHeight)&&(identical(other.isMaximized, isMaximized) || other.isMaximized == isMaximized)&&(identical(other.lastOpenedFolder, lastOpenedFolder) || other.lastOpenedFolder == lastOpenedFolder)&&const DeepCollectionEquality().equals(other._recentFolders, _recentFolders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,themeMode,language,firstLaunch,viewMode,zoomMode,autoHideControls,enablePageTurnAnimation,sourceLanguage,targetLanguage,translationEngine,enableAutoTranslate,enableOCR,fontStyle,fontSize,fontColor,windowWidth,windowHeight,isMaximized,lastOpenedFolder,const DeepCollectionEquality().hash(_recentFolders)]);

@override
String toString() {
  return 'AppConfig(themeMode: $themeMode, language: $language, firstLaunch: $firstLaunch, viewMode: $viewMode, zoomMode: $zoomMode, autoHideControls: $autoHideControls, enablePageTurnAnimation: $enablePageTurnAnimation, sourceLanguage: $sourceLanguage, targetLanguage: $targetLanguage, translationEngine: $translationEngine, enableAutoTranslate: $enableAutoTranslate, enableOCR: $enableOCR, fontStyle: $fontStyle, fontSize: $fontSize, fontColor: $fontColor, windowWidth: $windowWidth, windowHeight: $windowHeight, isMaximized: $isMaximized, lastOpenedFolder: $lastOpenedFolder, recentFolders: $recentFolders)';
}


}

/// @nodoc
abstract mixin class _$AppConfigCopyWith<$Res> implements $AppConfigCopyWith<$Res> {
  factory _$AppConfigCopyWith(_AppConfig value, $Res Function(_AppConfig) _then) = __$AppConfigCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode themeMode, String language, bool firstLaunch, ReaderViewMode viewMode, ZoomMode zoomMode, bool autoHideControls, bool enablePageTurnAnimation, String sourceLanguage, String targetLanguage, String translationEngine, bool enableAutoTranslate, bool enableOCR, TranslationFontStyle fontStyle, int fontSize, String fontColor, double windowWidth, double windowHeight, bool isMaximized, String? lastOpenedFolder, List<String> recentFolders
});




}
/// @nodoc
class __$AppConfigCopyWithImpl<$Res>
    implements _$AppConfigCopyWith<$Res> {
  __$AppConfigCopyWithImpl(this._self, this._then);

  final _AppConfig _self;
  final $Res Function(_AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? language = null,Object? firstLaunch = null,Object? viewMode = null,Object? zoomMode = null,Object? autoHideControls = null,Object? enablePageTurnAnimation = null,Object? sourceLanguage = null,Object? targetLanguage = null,Object? translationEngine = null,Object? enableAutoTranslate = null,Object? enableOCR = null,Object? fontStyle = null,Object? fontSize = null,Object? fontColor = null,Object? windowWidth = null,Object? windowHeight = null,Object? isMaximized = null,Object? lastOpenedFolder = freezed,Object? recentFolders = null,}) {
  return _then(_AppConfig(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,firstLaunch: null == firstLaunch ? _self.firstLaunch : firstLaunch // ignore: cast_nullable_to_non_nullable
as bool,viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as ReaderViewMode,zoomMode: null == zoomMode ? _self.zoomMode : zoomMode // ignore: cast_nullable_to_non_nullable
as ZoomMode,autoHideControls: null == autoHideControls ? _self.autoHideControls : autoHideControls // ignore: cast_nullable_to_non_nullable
as bool,enablePageTurnAnimation: null == enablePageTurnAnimation ? _self.enablePageTurnAnimation : enablePageTurnAnimation // ignore: cast_nullable_to_non_nullable
as bool,sourceLanguage: null == sourceLanguage ? _self.sourceLanguage : sourceLanguage // ignore: cast_nullable_to_non_nullable
as String,targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as String,translationEngine: null == translationEngine ? _self.translationEngine : translationEngine // ignore: cast_nullable_to_non_nullable
as String,enableAutoTranslate: null == enableAutoTranslate ? _self.enableAutoTranslate : enableAutoTranslate // ignore: cast_nullable_to_non_nullable
as bool,enableOCR: null == enableOCR ? _self.enableOCR : enableOCR // ignore: cast_nullable_to_non_nullable
as bool,fontStyle: null == fontStyle ? _self.fontStyle : fontStyle // ignore: cast_nullable_to_non_nullable
as TranslationFontStyle,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as int,fontColor: null == fontColor ? _self.fontColor : fontColor // ignore: cast_nullable_to_non_nullable
as String,windowWidth: null == windowWidth ? _self.windowWidth : windowWidth // ignore: cast_nullable_to_non_nullable
as double,windowHeight: null == windowHeight ? _self.windowHeight : windowHeight // ignore: cast_nullable_to_non_nullable
as double,isMaximized: null == isMaximized ? _self.isMaximized : isMaximized // ignore: cast_nullable_to_non_nullable
as bool,lastOpenedFolder: freezed == lastOpenedFolder ? _self.lastOpenedFolder : lastOpenedFolder // ignore: cast_nullable_to_non_nullable
as String?,recentFolders: null == recentFolders ? _self._recentFolders : recentFolders // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
