import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_in_my_fridge/models/list_item.dart';

class PrefService {
  final SharedPreferences _prefs;

  static PrefService? _instance;

  PrefService(this._prefs);

  static PrefService get get {
    if (_instance == null) {
      throw Exception("You need to call "
          "`await PrefService.init()` to be able to use PrefService.");
    }
    return _instance!;
  }

  static Future<void> init() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    _instance = PrefService(sharedPrefs);
  }

  static const _itemsKey = "items";

  Future<void> saveItems(List<ListItem> items) async {
    final json = items.map((e) => e.toJson()).toList(growable: false);
    _prefs.setString(_itemsKey, jsonEncode(json));
  }

  List<ListItem> loadItems() {
    final String string = _prefs.getString(_itemsKey) ?? "[]";
    final List json = jsonDecode(string);
    return json.map((e) => ListItem.fromJson(e)).toList();
  }


}
