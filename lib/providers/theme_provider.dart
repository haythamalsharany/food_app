import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primarColor = Colors.pink;
  var secondryColor = Colors.amber;
  var tm = ThemeMode.system;
  String themeText = 's';

  onChangeed(newColor, n) async {
    print("object__________________________valu is = $n");
    n == 1
        ? primarColor = _setMterialColor(newColor.hashCode)
        : secondryColor = _setMterialColor(newColor.hashCode);
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('primarColor', primarColor.value);
    sharedPreferences.setInt('secondryColor', secondryColor.value);
  }

  getPrefThemcolor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    primarColor =
        _setMterialColor(sharedPreferences.getInt('primarColor') ?? 0xFFE91E63);
    secondryColor = _setMterialColor(
        sharedPreferences.getInt('secondryColor') ?? 0xFFFFC107);
    notifyListeners();
  }

  MaterialColor _setMterialColor(colorval) {
    return MaterialColor(
      colorval,
      <int, Color>{
        50: Color(0xFFFCE4EC),
        100: Color(0xFFF8BBD0),
        200: Color(0xFFF48FB1),
        300: Color(0xFFF06292),
        400: Color(0xFFEC407A),
        500: Color(colorval),
        600: Color(0xFFD81B60),
        700: Color(0xFFC2185B),
        800: Color(0xFFAD1457),
        900: Color(0xFF880E4F),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeMode(tm);
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('themeText', themeText);
  }

  _getThemeMode(ThemeMode tm) {
    if (tm == ThemeMode.system) {
      themeText = 's';
    } else if (tm == ThemeMode.light) {
      themeText = 'l';
    } else if (tm == ThemeMode.dark) {
      themeText = 'd';
    }
  }

  getPrefThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    themeText = sharedPreferences.getString('themeText') ?? 's';
    if (themeText == 's') {
      tm = ThemeMode.system;
    } else if (themeText == 'l') {
      tm = ThemeMode.light;
    } else if (themeText == 'd') {
      tm = ThemeMode.dark;
    }
    notifyListeners();
  }
}
