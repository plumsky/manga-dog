import 'package:flutter/services.dart';
import 'dart:async';

class KeyboardManager {
  final Map<String, ShortcutBinding> _shortcuts = {};
  final Map<LogicalKeyboardKey, List<VoidCallback>> _keyDownHandlers = {};
  final Map<LogicalKeyboardKey, List<VoidCallback>> _keyUpHandlers = {};
  final Set<LogicalKeyboardKey> _pressedKeys = {};
  Timer? _holdTimer;
  final List<String> _keyHistory = [];
  static const int maxHistory = 50;

  /// register a keyboard shortcut
  void registerShortcut({
    required String id,
    required List<LogicalKeyboardKey> keys,
    required VoidCallback callback,
    String? description,
    bool preventDefault = true,
  }) {
    _shortcuts[id] = ShortcutBinding(
      keys: keys,
      callback: callback,
      description: description,
      preventDefault: preventDefault,
    );
  }

  /// register key event handlers
  void registerKeyEvent({
    required LogicalKeyboardKey key,
    VoidCallback? onDown,
    VoidCallback? onUp,
    VoidCallback? onHold,
  }) {
    if (onDown != null) {
      _keyDownHandlers.putIfAbsent(key, () => []).add(onDown);
    }
    if (onUp != null) {
      _keyUpHandlers.putIfAbsent(key, () => []).add(onUp);
    }
  }

  /// handle key events
  void handleKeyEvent(KeyEvent event) {
    final key = event.logicalKey;
    final time = DateTime.now();

    if (event is KeyDownEvent) {
      _pressedKeys.add(key);
      _addToHistory('Check: ${key.keyLabel}', time);

      /// process key down event
      _keyDownHandlers[key]?.forEach((handler) => handler());

      /// check for hold event
      _checkShortcuts();

    } else if (event is KeyUpEvent) {
      _pressedKeys.remove(key);
      _addToHistory('Release: ${key.keyLabel}', time);

      /// process key up event
      _keyUpHandlers[key]?.forEach((handler) => handler());

      /// cancel hold timer
      _holdTimer?.cancel();
    }
  }

  /// check if the current pressed keys match the shortcut
  bool _matchesShortcut(List<LogicalKeyboardKey> shortcutKeys) {
    /// check if all keys in the shortcut are pressed
    for (var key in shortcutKeys) {
      if (!_isKeyPressed(key)) {
        return false;
      }
    }

    return true;
  }

  /// check if a key is currently pressed
  bool _isKeyPressed(LogicalKeyboardKey key) {
    /// modifier key
    if (key == LogicalKeyboardKey.control ||
        key == LogicalKeyboardKey.controlLeft ||
        key == LogicalKeyboardKey.controlRight) {
      return HardwareKeyboard.instance.isControlPressed;
    } else if (key == LogicalKeyboardKey.shift ||
        key == LogicalKeyboardKey.shiftLeft ||
        key == LogicalKeyboardKey.shiftRight) {
      return HardwareKeyboard.instance.isShiftPressed;
    } else if (key == LogicalKeyboardKey.alt ||
        key == LogicalKeyboardKey.altLeft ||
        key == LogicalKeyboardKey.altRight) {
      return HardwareKeyboard.instance.isAltPressed;
    } else if (key == LogicalKeyboardKey.meta ||
        key == LogicalKeyboardKey.metaLeft ||
        key == LogicalKeyboardKey.metaRight) {
      return HardwareKeyboard.instance.isMetaPressed;
    }

    /// normal key
    return _pressedKeys.contains(key);
  }

  /// check and trigger shortcuts
  void _checkShortcuts() {
    for (var binding in _shortcuts.values) {
      if (_matchesShortcut(binding.keys)) {
        binding.callback();
        break;
      }
    }
  }

  /// add action to history
  void _addToHistory(String action, DateTime time) {
    final entry = '${time.toString().substring(11, 19)} - $action';
    _keyHistory.insert(0, entry);
    if (_keyHistory.length > maxHistory) {
      _keyHistory.removeLast();
    }
  }

  /// get key history
  List<String> getKeyHistory() => List.from(_keyHistory);

  /// get currently pressed keys
  List<LogicalKeyboardKey> getPressedKeys() => List.from(_pressedKeys);

  /// get registered shortcuts
  Map<String, ShortcutBinding> get shortcuts => Map.from(_shortcuts);

  /// clear all registered shortcuts and handlers
  void clear() {
    _shortcuts.clear();
    _keyDownHandlers.clear();
    _keyUpHandlers.clear();
    _pressedKeys.clear();
    _holdTimer?.cancel();
    _keyHistory.clear();
  }

  void dispose() {
    clear();
  }

  void unregisterKeyEvent(LogicalKeyboardKey arrowRight) {
    _keyDownHandlers.remove(arrowRight);
    _keyUpHandlers.remove(arrowRight);
  }
}

class ShortcutBinding {
  final List<LogicalKeyboardKey> keys;
  final VoidCallback callback;
  final String? description;
  final bool preventDefault;

  ShortcutBinding({
    required this.keys,
    required this.callback,
    this.description,
    this.preventDefault = true,
  });
}
