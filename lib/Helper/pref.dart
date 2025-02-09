import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Pref {
  static late Box _box;

  static Future<void> initialize() async {
    Hive.init((await getApplicationDocumentsDirectory()).path); // Set directory
    _box = await Hive.openBox("myData"); // Open box
  }

  static bool get showOnboard => _box.get("showOnBoarding", defaultValue: true);

  static set showOnboard(bool value) => _box.put("showOnBoarding", value);
}
