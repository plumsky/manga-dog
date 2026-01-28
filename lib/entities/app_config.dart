import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'app_setting.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default('zh-CN') String language,
    @Default(true) bool firstLaunch,
    @Default(ReaderViewMode.single) ReaderViewMode viewMode,
    @Default(ZoomMode.fitWidth) ZoomMode zoomMode,
    @Default(true) bool autoHideControls,
    @Default(true) bool enablePageTurnAnimation,
    @Default('auto') String sourceLanguage,
    @Default('zh-CN') String targetLanguage,
    @Default('google') String translationEngine,
    @Default(false) bool enableAutoTranslate,
    @Default(true) bool enableOCR,
    @Default(TranslationFontStyle.comic) TranslationFontStyle fontStyle,
    @Default(16) int fontSize,
    @Default('#000000') String fontColor,
    @Default(1280.0) double windowWidth,
    @Default(720.0) double windowHeight,
    @Default(false) bool isMaximized,
    String? lastOpenedFolder,
    @Default([]) List<String> recentFolders
  }) = _AppConfig;

  factory AppConfig.fromSetting(AppSetting settings) {
    return AppConfig(
      themeMode: ThemeMode.values[settings.themeModeIndex],
      language: settings.language,
      firstLaunch: settings.firstLaunch,
      viewMode: settings.viewModeEnum,
      zoomMode: settings.zoomModeEnum,
      autoHideControls: settings.autoHideControls,
      enablePageTurnAnimation: settings.enablePageTurnAnimation,
      sourceLanguage: settings.sourceLanguage,
      targetLanguage: settings.targetLanguage,
      translationEngine: settings.translationEngine,
      enableAutoTranslate: settings.enableAutoTranslate,
      enableOCR: settings.enableOCR,
      fontStyle: settings.fontStyleEnum,
      fontSize: settings.fontSize,
      fontColor: settings.fontColor,
      windowWidth: settings.windowWidth,
      windowHeight: settings.windowHeight,
      isMaximized: settings.isMaximized,
      lastOpenedFolder: settings.lastOpenedFolder,
      recentFolders: settings.recentFolders,
    );
  }
  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}
