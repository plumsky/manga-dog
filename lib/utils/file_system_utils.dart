import 'dart:io';
import 'package:path/path.dart' as p;

import 'app_logger.dart';
import 'path_validator.dart';

class FileSystemUtils {
  /// Get all files in a directory (non-recursive)
  static Future<List<FileSystemEntity>> getFilesInDirectory(String dirPath) async {
    try {
      final directory = Directory(dirPath);
      if (!await directory.exists()) {
        AppLogger.warning('Dir not exist: $dirPath');
        return [];
      }

      final entities = await directory.list().toList();

      /// no dir or other entity, only files
      final files = entities.where((entity) {
        return FileSystemEntity.isFileSync(entity.path);
      }).toList();

      return files;
    } catch (e) {
      AppLogger.error('Get files failed: $e');
      return [];
    }
  }

  /// Get files with specific extensions, optionally recursively
  static Future<List<File>> getFilesWithFilter(
      String dirPath, {
        List<String>? extensions,
        bool recursive = false,
      }) async {
    try {
      final directory = Directory(dirPath);
      if (!await directory.exists()) {
        return [];
      }

      final stream = directory.list(recursive: recursive);
      final files = <File>[];

      await for (final entity in stream) {
        if (entity is File) {
          if (extensions == null || extensions.isEmpty) {
            files.add(entity);
          } else {
            final ext = p.extension(entity.path).toLowerCase();
            if (extensions.any((e) => ext == '.${e.toLowerCase()}')) {
              files.add(entity);
            }
          }
        }
      }

      return files;
    } catch (e) {
      AppLogger.error('Get files failed: $e');
      return [];
    }
  }

  /// Get all files in a directory synchronously (non-recursive)
  static List<FileSystemEntity> getFilesInDirectorySync(String dirPath) {
    try {
      final directory = Directory(dirPath);
      if (!directory.existsSync()) {
        return [];
      }

      final entities = directory.listSync();
      /// no dir or other entity, only files
      final files = entities.where((entity) {
        return FileSystemEntity.isFileSync(entity.path);
      }).toList();

      return files;
    } catch (e) {
      AppLogger.error('Get files failed: $e');
      return [];
    }
  }

  /// Get files sorted by modified time
  static List<FileSystemEntity> getSortedFiles(
      String dirPath, {
        bool ascending = false,
      }) {
    final files = getFilesInDirectorySync(dirPath);

    files.sort((a, b) {
      final aStat = a.statSync();
      final bStat = b.statSync();
      return ascending
          ? aStat.modified.compareTo(bStat.modified)
          : bStat.modified.compareTo(aStat.modified);
    });

    return files;
  }

  /// Check if the file exists
  static Future<bool> isExistingFile(String path) async {
    try {
      if (!PathValidator.isValidPathFormat(path)) {
        return false;
      }

      final file = File(path);
      final exists = await file.exists();
      if (!exists) return false;

      final stat = await file.stat();
      return stat.type == FileSystemEntityType.file;

    } catch (e) {
      AppLogger.error('Get file exist failed: $e');
      return false;
    }
  }

  /// check if the directory exists
  static Future<bool> isExistingDirectory(String path) async {
    try {
      if (!PathValidator.isValidPathFormat(path)) {
        return false;
      }

      final dir = Directory(path);
      final exists = await dir.exists();
      if (!exists) return false;

      final stat = await dir.stat();
      return stat.type == FileSystemEntityType.directory;

    } catch (e) {
      AppLogger.error('Check path exist failed: $e');
      return false;
    }
  }

  /// check the type of the path
  static Future<FileSystemEntityType?> getPathType(String path) async {
    try {
      if (!PathValidator.isValidPathFormat(path)) {
        return null;
      }

      final entity = File(path);
      final exists = await entity.exists();
      if (!exists) return null;

      final stat = await entity.stat();
      return stat.type;

    } catch (e) {
      AppLogger.error('Get path type failed: $e');
      return null;
    }
  }
}
