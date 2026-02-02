
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox/objectbox.dart';

import '../core/objectbox_database.dart';
import '../models/objectbox_models.dart';

final objectBoxDatabaseProvider = FutureProvider<ObjectBoxDatabase>((ref) async {
  return ObjectBoxDatabase.getInstance();
});

final mangaBoxProvider = FutureProvider<Box<Manga>>((ref) async {
  final db = await ref.watch(objectBoxDatabaseProvider.future);
  return db.mangaBox;
});

final translationCacheBoxProvider = FutureProvider<Box<TranslationCache>>((ref) async {
  final db = await ref.watch(objectBoxDatabaseProvider.future);
  return db.translationCacheBox;
});

final recentManagerProvider = FutureProvider<List<Manga>>((ref) async {
  final db = await ref.read(objectBoxDatabaseProvider.future);
  final allMangas = db.mangaBox.getAll();
  return allMangas.take(10).toList();
});

final databaseStatsProvider = FutureProvider<DatabaseStats>((ref) async {
  final db = await ref.read(objectBoxDatabaseProvider.future);
  return await db.getStats();
});
