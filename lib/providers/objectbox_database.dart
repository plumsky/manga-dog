
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

// 用于实时查询的Provider
// final mangaQueryProvider = StreamProvider<List<Manga>>((ref) async* {
//   final db = await ref.watch(objectBoxDatabaseProvider.future);
//   final query = db.mangaBox.query()
//       .order(Manga_.lastReadAt, flags: Order.descending)
//       .build();
//
//   yield* query
//       .watch(triggerImmediately: true)
//       .map((query) => query.find());
// });
