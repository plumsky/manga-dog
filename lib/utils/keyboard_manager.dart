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

  // 注册快捷键
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

  // 注册按键事件
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

  // 处理键盘事件
  void handleKeyEvent(KeyEvent event) {
    final key = event.logicalKey;
    final time = DateTime.now();

    if (event is KeyDownEvent) {
      _pressedKeys.add(key);
      _addToHistory('按下: ${key.keyLabel}', time);

      // 处理按键按下事件
      _keyDownHandlers[key]?.forEach((handler) => handler());

      // 检查快捷键
      _checkShortcuts();

    } else if (event is KeyUpEvent) {
      _pressedKeys.remove(key);
      _addToHistory('释放: ${key.keyLabel}', time);

      // 处理按键释放事件
      _keyUpHandlers[key]?.forEach((handler) => handler());

      // 取消长按计时
      _holdTimer?.cancel();
    }
  }

  // 检查快捷键是否匹配
  bool _matchesShortcut(List<LogicalKeyboardKey> shortcutKeys) {
    // 检查所有快捷键键是否都被按下
    for (var key in shortcutKeys) {
      if (!_isKeyPressed(key)) {
        return false;
      }
    }

    return true;
  }

  // 检查单个键是否被按下
  bool _isKeyPressed(LogicalKeyboardKey key) {
    // 处理修饰键
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

    // 处理普通键
    return _pressedKeys.contains(key);
  }

  // 检查所有快捷键
  void _checkShortcuts() {
    for (var binding in _shortcuts.values) {
      if (_matchesShortcut(binding.keys)) {
        binding.callback();
        break; // 只触发一个快捷键
      }
    }
  }

  // 添加快捷键历史
  void _addToHistory(String action, DateTime time) {
    final entry = '${time.toString().substring(11, 19)} - $action';
    _keyHistory.insert(0, entry);
    if (_keyHistory.length > maxHistory) {
      _keyHistory.removeLast();
    }
  }

  // 获取按键历史
  List<String> getKeyHistory() => List.from(_keyHistory);

  // 获取当前按下的键
  List<LogicalKeyboardKey> getPressedKeys() => List.from(_pressedKeys);

  // 获取所有注册的快捷键
  Map<String, ShortcutBinding> get shortcuts => Map.from(_shortcuts);

  // 清空所有注册
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
