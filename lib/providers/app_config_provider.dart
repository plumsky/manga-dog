import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manga_dog/utils/app_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entities/app_config.dart';
import '../entities/app_setting.dart';
import '../objectbox.g.dart';
import 'objectbox_database.dart';

part 'app_config_provider.g.dart';

@riverpod
class AppConfigNotifier extends _$AppConfigNotifier {
  late Box<AppSetting> _settingsBox;
  AppSetting? _settings;
  Timer? _pollingTimer;
  DateTime? _lastUpdated;

  @override
  AppConfig build() {
    // 初始化时加载配置
    _initialize();
    return const AppConfig();
  }

  Future<void> _initialize() async {
    try {
      final db = ref.read(objectBoxDatabaseProvider.future);
      await db.then((database) async {
        _settingsBox = database.appSettingsBox;

        // 检查是否有现有的设置
        _settings = _settingsBox.get(1); // 使用ID 1作为全局设置

        if (_settings == null) {
          // 创建默认设置
          _settings = AppSetting(id: 1);
          _settingsBox.put(_settings!);
        }

        // 更新状态
        state = AppConfig.fromSetting(_settings!);

        _startPolling();
      });
    } catch (e) {
      AppLogger.error('Init config failed: $e');
      /// Use default config on error
      state = const AppConfig();
    }
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _pollForChanges();
    });

    ref.onDispose(() {
      _pollingTimer?.cancel();
    });
  }

  Future<void> _pollForChanges() async {
    try {
      final currentSettings = _settingsBox.get(1);
      if (currentSettings != null) {
        if (_lastUpdated == null ||
            currentSettings.updatedAt != _lastUpdated) {
          _settings = currentSettings;
          _lastUpdated = currentSettings.updatedAt;
          state = AppConfig.fromSetting(currentSettings);
        }
      }
    } catch (e) {
      AppLogger.error('Settings polling failed: $e');
    }
  }

  Future<void> _updateSettings(AppSetting Function(AppSetting settings) updateFn) async {
    if (_settings != null) {
      final updated = updateFn(_settings!);
      updated.updatedAt = DateTime.now();

      await _settingsBox.putAsync(updated);
      _settings = updated;
      state = AppConfig.fromSetting(updated);
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _updateSettings((settings) {
      settings.themeModeIndex = themeMode.index;
      return settings;
    });
  }

  Future<void> setLanguage(String language) async {
    await _updateSettings((settings) {
      settings.language = language;
      return settings;
    });
  }

  Future<void> setFirstLaunch(bool firstLaunch) async {
    await _updateSettings((settings) {
      settings.firstLaunch = firstLaunch;
      return settings;
    });
  }

  Future<void> setViewMode(ReaderViewMode viewMode) async {
    await _updateSettings((settings) {
      settings.viewModeEnum = viewMode;
      return settings;
    });
  }

  Future<void> setZoomMode(ZoomMode zoomMode) async {
    await _updateSettings((settings) {
      settings.zoomModeEnum = zoomMode;
      return settings;
    });
  }

  Future<void> setAutoHideControls(bool autoHideControls) async {
    await _updateSettings((settings) {
      settings.autoHideControls = autoHideControls;
      return settings;
    });
  }

  Future<void> setPageTurnAnimation(bool enable) async {
    await _updateSettings((settings) {
      settings.enablePageTurnAnimation = enable;
      return settings;
    });
  }

  Future<void> setTranslationConfig({
    String? sourceLanguage,
    String? targetLanguage,
    String? translationEngine,
    bool? enableAutoTranslate,
    bool? enableOCR,
    TranslationFontStyle? fontStyle,
    int? fontSize,
    String? fontColor,
  }) async {
    await _updateSettings((settings) {
      if (sourceLanguage != null) settings.sourceLanguage = sourceLanguage;
      if (targetLanguage != null) settings.targetLanguage = targetLanguage;
      if (translationEngine != null) settings.translationEngine = translationEngine;
      if (enableAutoTranslate != null) settings.enableAutoTranslate = enableAutoTranslate;
      if (enableOCR != null) settings.enableOCR = enableOCR;
      if (fontStyle != null) settings.fontStyleEnum = fontStyle;
      if (fontSize != null) settings.fontSize = fontSize;
      if (fontColor != null) settings.fontColor = fontColor;
      return settings;
    });
  }

  Future<void> setWindowConfig({
    double? width,
    double? height,
    bool? isMaximized,
  }) async {
    await _updateSettings((settings) {
      if (width != null) settings.windowWidth = width;
      if (height != null) settings.windowHeight = height;
      if (isMaximized != null) settings.isMaximized = isMaximized;
      return settings;
    });
  }

  Future<void> setLastOpenedFolder(String path) async {
    await _updateSettings((settings) {
      settings.lastOpenedFolder = path;
      return settings;
    });
  }

  Future<void> addRecentFolder(String path) async {
    await _updateSettings((settings) {
      final recent = List<String>.from(settings.recentFolders);
      recent.remove(path);
      recent.insert(0, path);
      if (recent.length > 10) recent.removeLast();
      settings.recentFolders = recent;
      return settings;
    });
  }

  Future<void> resetToDefaults() async {
    final defaultSettings = AppSetting(id: 1);
    await _settingsBox.putAsync(defaultSettings);
    _settings = defaultSettings;
    state = AppConfig.fromSetting(defaultSettings);
  }
}
