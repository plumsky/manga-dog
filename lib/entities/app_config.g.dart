// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => _AppConfig(
  themeMode:
      $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
      ThemeMode.system,
  language: json['language'] as String? ?? 'zh-CN',
  firstLaunch: json['firstLaunch'] as bool? ?? true,
  viewMode:
      $enumDecodeNullable(_$ReaderViewModeEnumMap, json['viewMode']) ??
      ReaderViewMode.single,
  zoomMode:
      $enumDecodeNullable(_$ZoomModeEnumMap, json['zoomMode']) ??
      ZoomMode.fitWidth,
  autoHideControls: json['autoHideControls'] as bool? ?? true,
  enablePageTurnAnimation: json['enablePageTurnAnimation'] as bool? ?? true,
  sourceLanguage: json['sourceLanguage'] as String? ?? 'auto',
  targetLanguage: json['targetLanguage'] as String? ?? 'zh-CN',
  translationEngine: json['translationEngine'] as String? ?? 'google',
  enableAutoTranslate: json['enableAutoTranslate'] as bool? ?? false,
  enableOCR: json['enableOCR'] as bool? ?? true,
  fontStyle:
      $enumDecodeNullable(_$TranslationFontStyleEnumMap, json['fontStyle']) ??
      TranslationFontStyle.comic,
  fontSize: (json['fontSize'] as num?)?.toInt() ?? 16,
  fontColor: json['fontColor'] as String? ?? '#000000',
  windowWidth: (json['windowWidth'] as num?)?.toDouble() ?? 1280.0,
  windowHeight: (json['windowHeight'] as num?)?.toDouble() ?? 720.0,
  isMaximized: json['isMaximized'] as bool? ?? false,
  lastOpenedFolder: json['lastOpenedFolder'] as String?,
  recentFolders:
      (json['recentFolders'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$AppConfigToJson(_AppConfig instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'language': instance.language,
      'firstLaunch': instance.firstLaunch,
      'viewMode': _$ReaderViewModeEnumMap[instance.viewMode]!,
      'zoomMode': _$ZoomModeEnumMap[instance.zoomMode]!,
      'autoHideControls': instance.autoHideControls,
      'enablePageTurnAnimation': instance.enablePageTurnAnimation,
      'sourceLanguage': instance.sourceLanguage,
      'targetLanguage': instance.targetLanguage,
      'translationEngine': instance.translationEngine,
      'enableAutoTranslate': instance.enableAutoTranslate,
      'enableOCR': instance.enableOCR,
      'fontStyle': _$TranslationFontStyleEnumMap[instance.fontStyle]!,
      'fontSize': instance.fontSize,
      'fontColor': instance.fontColor,
      'windowWidth': instance.windowWidth,
      'windowHeight': instance.windowHeight,
      'isMaximized': instance.isMaximized,
      'lastOpenedFolder': instance.lastOpenedFolder,
      'recentFolders': instance.recentFolders,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$ReaderViewModeEnumMap = {
  ReaderViewMode.single: 'single',
  ReaderViewMode.double: 'double',
  ReaderViewMode.webtoon: 'webtoon',
};

const _$ZoomModeEnumMap = {
  ZoomMode.fitWidth: 'fitWidth',
  ZoomMode.fitHeight: 'fitHeight',
  ZoomMode.original: 'original',
  ZoomMode.custom: 'custom',
};

const _$TranslationFontStyleEnumMap = {
  TranslationFontStyle.comic: 'comic',
  TranslationFontStyle.normal: 'normal',
  TranslationFontStyle.bold: 'bold',
  TranslationFontStyle.italic: 'italic',
};
