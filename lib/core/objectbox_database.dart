import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../entities/app_setting.dart';
import '../models/objectbox_models.dart';
import '../objectbox.g.dart';

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
      String dbPath = await _getDBStoreFilePath();

      final store = await openStore(
        directory: dbPath,
        macosApplicationGroup: 'manga.dog.db',
      );
      _instance = ObjectBoxDatabase._create(store);
    }

    return _instance!;
  }

  static Future<String> _getDBStoreFilePath() async {
    Directory dir;
    if (Platform.isMacOS) {
      dir = await getApplicationSupportDirectory();
    } else if (Platform.isWindows) {
      dir = await getApplicationSupportDirectory();
    } else if (Platform.isLinux) {
      dir = await getApplicationSupportDirectory();
    } else {
      dir = await getApplicationDocumentsDirectory();
    }
    final dbPath = p.join(dir.path, 'manga_reader_objectbox');
    return dbPath;
  }

  /// Accessors for boxes
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

  /// Clear all data in the database
  Future<void> clearAll() async {
    await _store.runInTransaction(TxMode.write, () {
      _mangaBox.removeAll();
      _bookmarkBox.removeAll();
      _translationCacheBox.removeAll();
      _readingHistoryBox.removeAll();
    });
  }

  /// Get database statistics
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
    final dbPath = await _getDBStoreFilePath();
    final dataFile = File(p.join(dbPath, 'data.mdb'));

    if (await dataFile.exists()) {
      return await dataFile.length();
    }

    return 0;
  }

  /// Path or folderPath get manga
  Future<Manga?> getMangaByPath(String path) async {
    final query = _mangaBox.query(Manga_.folderPath.equals(path)).build();
    try {
      final result = query.findFirst();
      return result;
    } finally {
      query.close();
    }
  }

  /// Add or update manga by path
  Future<Manga> addOrUpdateMangaByPath({
    required String path,
    required String title,
    String? coverPath,
    int? totalPages,
    Map<String, dynamic>? metadata,
  }) async {
    final query = _mangaBox.query(Manga_.folderPath.equals(path)).build();

    try {
      final existingManga = query.findFirst();
      Manga mangaToSave;

      if (existingManga != null) {
        existingManga.lastReadAt = DateTime.now();
        if (coverPath != null) existingManga.coverPath = coverPath;
        if (totalPages != null) existingManga.totalPages = totalPages;
        mangaToSave = existingManga;
      } else {
        mangaToSave = Manga(
          folderPath: path,
          title: title,
          coverPath: coverPath,
          totalPages: totalPages,
          lastReadAt: DateTime.now(),
        );
      }

      final id = _store.runInTransaction(TxMode.write, () {
        return _mangaBox.put(mangaToSave);
      });

      mangaToSave.id = id;
      return mangaToSave;
    } finally {
      query.close();
    }
  }

  /// Get or create manga by path
  Future<Manga> getOrCreateManga({
    required String path,
    required String title,
    String? coverPath,
    int? totalPages,
    Map<String, dynamic>? metadata,
  }) async {
    final existingManga = await getMangaByPath(path);

    if (existingManga != null) {
      existingManga.lastReadAt = DateTime.now();
      _mangaBox.put(existingManga);
      return existingManga;
    }

    return await addOrUpdateMangaByPath(
      path: path,
      title: title,
      coverPath: coverPath,
      totalPages: totalPages,
      metadata: metadata,
    );
  }

  /// Update manga last opened time by paths
  Future<void> updateMangaLastOpened(List<String> paths) async {
    await _store.runInTransaction(TxMode.write, () async {
      final query = _mangaBox.query(Manga_.folderPath.oneOf(paths)).build();
      try {
        final mangas = query.find();
        final now = DateTime.now();

        for (final manga in mangas) {
          manga.lastReadAt = now;
        }

        _mangaBox.putMany(mangas);
      } finally {
        query.close();
      }
    });
  }

  /// Remove manga by path
  Future<bool> removeMangaByPath(String path) async {
    final manga = await getMangaByPath(path);
    if (manga != null) {
      return _mangaBox.remove(manga.id);
    }
    return false;
  }

  /// Get recently opened manga
  Future<List<Manga>> getRecentlyOpenedManga({
    int limit = 20,
    int offset = 0,
  }) async {
    final query = _mangaBox
        .query()
        .order(Manga_.lastReadAt, flags: Order.descending)
        .build();

    try {
      final allResults = query.find();

      final startIndex = offset;
      final endIndex = offset + limit;

      if (startIndex >= allResults.length) {
        return [];
      }

      if (endIndex > allResults.length) {
        return allResults.sublist(startIndex);
      }

      return allResults.sublist(startIndex, endIndex);
    } finally {
      query.close();
    }
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
