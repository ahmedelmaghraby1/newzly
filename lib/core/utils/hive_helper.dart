import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static Future<void> initHive() async {
    await Hive.initFlutter();

    await Hive.openBox<dynamic>('settings');
  }

  static ValueListenable<Box<dynamic>> settingsListenable() {
    return Hive.box<dynamic>('settings').listenable();
  }
}
