import 'dart:io';

import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../entities/app_setting.dart';
import '../models/objectbox_models.dart';
import 'objectbox_store.dart';

class ObjectBoxDatabase {
  late final Store _store;
  late final Box<Manga> _mangaBox;
  late final Box<Bookmark> _bookmarkBox;
  late final Box<TranslationCache> _translationCacheBox;
  late final Box<ReadingHistory> _readingHistoryBox;
  late final Box<AppSetting> _appSettingBox;

  static ObjectBoxDatabase? _instance;

  ObjectBoxDatabase._create(this._store) {
    _mangaBox = Box<Manga>(_store);
    _bookmarkBox = Box<Bookmark>(_store);
    _translationCacheBox = Box<TranslationCache>(_store);
    _readingHistoryBox = Box<ReadingHistory>(_store);
    _appSettingBox = Box<AppSetting>(_store);
  }

  static Future<ObjectBoxDatabase> getInstance() async {
    if (_instance == null) {
      final dir = await getApplicationDocumentsDirectory();
      final dbPath = p.join(dir.path, 'manga_reader_objectbox');

      final store = await openStore(directory: dbPath);
      _instance = ObjectBoxDatabase._create(store);
    }

    return _instance!;
  }

  // 获取Box的getter
  Box<Manga> get mangaBox => _mangaBox;
  Box<Bookmark> get bookmarkBox => _bookmarkBox;
  Box<TranslationCache> get translationCacheBox => _translationCacheBox;
  Box<ReadingHistory> get readingHistoryBox => _readingHistoryBox;
  Box<AppSetting> get appSettingsBox => _appSettingBox;

  Store get store => _store;

  Future<void> close() async {
    _store.close();
    _instance = null;
  }

  // 清空所有数据（开发用）
  Future<void> clearAll() async {
    await _store.runInTransaction(TxMode.write, () {
      _mangaBox.removeAll();
      _bookmarkBox.removeAll();
      _translationCacheBox.removeAll();
      _readingHistoryBox.removeAll();
    });
  }

  // 获取数据库统计信息
  Future<DatabaseStats> getStats() async {
    return DatabaseStats(
      mangaCount: _mangaBox.count(),
      bookmarkCount: _bookmarkBox.count(),
      translationCacheCount: _translationCacheBox.count(),
      readingHistoryCount: _readingHistoryBox.count(),
      databaseSize: await _getDatabaseSize(),
    );
  }

  Future<int> _getDatabaseSize() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbDir = p.join(dir.path, 'manga_reader_objectbox');
    final dataFile = File(p.join(dbDir, 'data.mdb'));

    if (await dataFile.exists()) {
      return await dataFile.length();
    }

    return 0;
  }
}

class DatabaseStats {
  final int mangaCount;
  final int bookmarkCount;
  final int translationCacheCount;
  final int readingHistoryCount;
  final int databaseSize;

  DatabaseStats({
    required this.mangaCount,
    required this.bookmarkCount,
    required this.translationCacheCount,
    required this.readingHistoryCount,
    required this.databaseSize,
  });
}
