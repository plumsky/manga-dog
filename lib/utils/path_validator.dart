import 'dart:io';
import 'package:path/path.dart' as p;

class PathValidator {
  /// check if the path format is valid
  static bool isValidPathFormat(String path) {
    if (path.isEmpty) return false;

    // 1. no invalid characters
    // path characters not allowed in Windows and Unix-like systems
    final invalidChars = RegExp(r'[<>:"|?*\x00-\x1F]');
    if (invalidChars.hasMatch(path)) {
      return false;
    }

    // 2. check platform specific rules
    if (Platform.isWindows) {
      // Windows path length limits
      if (path.length > 260) return false; // MAX_PATH

      // check reserved names
      final reservedNames = [
        'CON', 'PRN', 'AUX', 'NUL',
        'COM1', 'COM2', 'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9',
        'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8', 'LPT9',
      ];

      final fileName = p.basenameWithoutExtension(path).toUpperCase();
      if (reservedNames.contains(fileName)) {
        return false;
      }
    } else {
      // Unix-like systems
      if (path.length > 4096) return false; // PATH_MAX
    }

    // 3. check each path component
    final components = p.split(path);
    for (final component in components) {
      if (component.isEmpty) continue;

      // check length of each component
      if (component.length > 255) return false;

      // no trailing spaces or dots
      if (component.endsWith(' ') || component.endsWith('.')) {
        return false;
      }

      // special components
      if (component == '.' || component == '..') {
        continue;
      }
    }

    return true;
  }

  /// check if the path looks like a directory path
  static bool looksLikeDirectoryPath(String path) {
    if (!isValidPathFormat(path)) return false;

    // 1. ends with separator
    if (path.endsWith(p.separator) || path.endsWith('/')) {
      return true;
    }

    // 2. no extension
    final extension = p.extension(path);
    if (extension.isEmpty) {
      return true;
    }

    // 3. not a common file name
    final dirNames = ['node_modules', '.git', 'build', 'dist', 'lib', 'src'];
    final dirName = p.basename(path);
    if (dirNames.contains(dirName)) {
      return true;
    }

    return false;
  }

  /// Check if the path looks like a file path
  static bool looksLikeFilePath(String path) {
    if (!isValidPathFormat(path)) return false;

    // 1. has extension
    final extension = p.extension(path);
    if (extension.isNotEmpty && extension != '.') {
      return true;
    }

    // 2. not ends with separator
    if (!path.endsWith(p.separator) && !path.endsWith('/')) {
      return true;
    }

    return false;
  }
}
