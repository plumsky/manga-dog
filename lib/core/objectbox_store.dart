import 'dart:io';

import 'package:path/path.dart' as p;

import '../objectbox.g.dart';

Future<Store> openStore({required String directory, String? name}) async {
  // 确保目录存在
  await Directory(directory).create(recursive: true);

  return Store(
    getObjectBoxModel(),
    directory: p.join(directory, name ?? 'objectbox'),
    queriesCaseSensitiveDefault: false,
    maxDBSizeInKB: 1024 * 1024,  // 1GB最大大小
  );
}
