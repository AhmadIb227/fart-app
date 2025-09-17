import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class GroupPrefsService {
  static final _box = GetStorage('group_prefs');

  static Map<String, dynamic> _data(String gid) =>
      Map<String, dynamic>.from(_box.read(gid) ?? {});

  static void _write(String gid, Map<String, dynamic> m) => _box.write(gid, m);

  // getters
  static bool isMuted(String gid) => _data(gid)['mute'] == true;
  static String tone(String gid) => _data(gid)['tone'] ?? 'Default';
  static bool isProtected(String gid) => _data(gid)['protected'] == true;
  static bool isHidden(String gid) => _data(gid)['hidden'] == true;
  static bool hideHistory(String gid) => _data(gid)['hideHistory'] == true;
  static Color? customColor(String gid) {
    final v = _data(gid)['color'];
    if (v is int) return Color(v);
    return null;
  }

  static String? backgroundPath(String gid) => _data(gid)['bgPath'];

  // setters
  static Future<void> setMuted(String gid, bool v) async {
    final m = _data(gid)..['mute'] = v;
    _write(gid, m);
  }

  static Future<void> setTone(String gid, String name) async {
    final m = _data(gid)..['tone'] = name;
    _write(gid, m);
  }

  static Future<void> setProtected(String gid, bool v) async {
    final m = _data(gid)..['protected'] = v;
    _write(gid, m);
  }

  static Future<void> setHidden(String gid, bool v) async {
    final m = _data(gid)..['hidden'] = v;
    _write(gid, m);
  }

  static Future<void> setHideHistory(String gid, bool v) async {
    final m = _data(gid)..['hideHistory'] = v;
    _write(gid, m);
  }

  static Future<void> setCustomColor(String gid, Color? c) async {
    final m = _data(gid);
    if (c == null) {
      m.remove('color');
    } else {
      m['color'] = c.value;
    }
    _write(gid, m);
  }

  static Future<void> setBackgroundPath(String gid, String? path) async {
    final m = _data(gid);
    if (path == null || path.isEmpty) {
      m.remove('bgPath');
    } else {
      m['bgPath'] = path;
    }
    _write(gid, m);
  }
}
