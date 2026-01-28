import 'dart:collection';
import 'dart:io';

class FilesSortHelper {
  static List<String> sortFilesByName(List<String> filePaths) {
    return filePaths..sort((a, b) => compare(a, b));
  }

  static List<File> sortFiles(List<File> files) {
    return List<File>.from(files)..sort((a, b) {
      final aName = a.path.split(Platform.pathSeparator).last;
      final bName = b.path.split(Platform.pathSeparator).last;
      return compare(aName, bName);
    });
  }

  static final _cache = HashMap<String, _CachedString>();

  /// Compare two strings in a natural order
  /// Returns:
  /// - negative if a < b
  /// - zero if a == b
  /// - positive if a > b
  static int compare(String a, String b, {bool caseSensitive = false}) {
    if (a == b) return 0;

    final cachedA = _cache[a] ?? _parseString(a, caseSensitive);
    final cachedB = _cache[b] ?? _parseString(b, caseSensitive);

    final aParts = cachedA.parts;
    final bParts = cachedB.parts;

    for (int i = 0; i < aParts.length && i < bParts.length; i++) {
      final aPart = aParts[i];
      final bPart = bParts[i];

      if (aPart is _CachedNumber && bPart is _CachedNumber) {
        if (aPart.value != bPart.value) {
          return aPart.value.compareTo(bPart.value);
        }
        if (aPart.leadingZeros != bPart.leadingZeros) {
          return aPart.leadingZeros.compareTo(bPart.leadingZeros);
        }
      } else if (aPart is _CachedText && bPart is _CachedText) {
        final comparison = aPart.text.compareTo(bPart.text);
        if (comparison != 0) return comparison;
      } else {
        return (aPart is _CachedNumber) ? -1 : 1;
      }
    }

    return aParts.length.compareTo(bParts.length);
  }

  static _CachedString _parseString(String str, bool caseSensitive) {
    final parts = <dynamic>[];
    int i = 0;

    while (i < str.length) {
      final code = str.codeUnitAt(i);

      if (_isDigit(code)) {
        // 解析数字
        int start = i;
        int leadingZeros = 0;
        int value = 0;

        // 前导零
        while (i < str.length && str.codeUnitAt(i) == 0x30) {
          leadingZeros++;
          i++;
        }

        // 数字值
        while (i < str.length && _isDigit(str.codeUnitAt(i))) {
          value = value * 10 + (str.codeUnitAt(i) - 0x30);
          i++;
        }

        parts.add(_CachedNumber(value, leadingZeros));
      } else {
        // 解析文本
        int start = i;
        final buffer = StringBuffer();

        while (i < str.length && !_isDigit(str.codeUnitAt(i))) {
          final char = str.codeUnitAt(i);
          buffer.writeCharCode(caseSensitive ? char : _toLowerCase(char));
          i++;
        }

        parts.add(_CachedText(buffer.toString()));
      }
    }

    final cached = _CachedString(str, parts);
    _cache[str] = cached;
    return cached;
  }

  static bool _isDigit(int code) => code >= 0x30 && code <= 0x39;

  static int _toLowerCase(int code) =>
      (code >= 0x41 && code <= 0x5A) ? code + 0x20 : code;
}

class _CachedString {
  final String original;
  final List<dynamic> parts;

  _CachedString(this.original, this.parts);
}

class _CachedNumber {
  final int value;
  final int leadingZeros;

  _CachedNumber(this.value, this.leadingZeros);
}

class _CachedText {
  final String text;

  _CachedText(this.text);
}
