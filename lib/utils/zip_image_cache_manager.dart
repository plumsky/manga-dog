import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';

class ZipImageCacheManager {
  final String zipPath;
  late Archive _archive;
  final Map<String, List<int>> _imageCache = {};

  ZipImageCacheManager(this.zipPath);

  Future<void> initialize() async {
    final bytes = await File(zipPath).readAsBytes();
    _archive = ZipDecoder().decodeBytes(bytes);
  }

  Future<Uint8List?> getImageData(String fileName) async {
    if (_imageCache.containsKey(fileName)) {
      return Uint8List.fromList(_imageCache[fileName]!);
    }

    final file = _archive.files.firstWhere(
      (f) => f.name == fileName && !f.isDirectory,
      orElse: () => throw Exception('File not found in zip: $fileName'),
    );

    final data = file.content as List<int>;
    _imageCache[fileName] = data;
    return Uint8List.fromList(data);
  }

  List<String> getImageFileNames() {
    return _archive.files
        .where((file) => !file.isDirectory && _isImageFile(file.name))
        .map((file) => file.name)
        .toList();
  }

  bool _isImageFile(String fileName) {
    final lowerName = fileName.toLowerCase();
    return lowerName.endsWith('.png') ||
        lowerName.endsWith('.jpg') ||
        lowerName.endsWith('.jpeg') ||
        lowerName.endsWith('.gif') ||
        lowerName.endsWith('.bmp') ||
        lowerName.endsWith('.webp');
  }

  Uint8List? getCachedImage(String path) {
    return _imageCache[path] == null
        ? null
        : Uint8List.fromList(_imageCache[path]!);
  }
}
