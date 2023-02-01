import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Modes extends ChangeNotifier {
  late int _status;
  Future<void> getStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _status = prefs.getInt('state') ?? 0;
    print("sate = ${_status}");
    notifyListeners();
  }

  Modes({int? isdark}) {
    _status = isdark ?? 0;
    print("states = = = = ${isdark}");
  }

  setToLight() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('state', 0);
    _status = 0;
    print("hellooo");
    notifyListeners();
  }

  setToDark() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('state', 1);
    _status = 1;
    print("hellooo1111111");
    int x = await prefs.getInt('state') ?? 22;
    print(x);
    notifyListeners();
  }

  int get ModeState => _status;
}
