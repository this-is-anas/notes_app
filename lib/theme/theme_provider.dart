import 'package:flutter/material.dart';
import 'package:note_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier{
  //Initially theme is in lightmode
  ThemeData _themeData = lightMode;

  //Getter method to access the theme from other part of the code
  ThemeData get themeData => _themeData;

  //getter method to see if we are dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  //Setter method to set the new theme
  set themeData(ThemeData themedata){
    _themeData = themedata;
    notifyListeners();
  }

  //To toggle between light mode and dark mode will be use in switch
  void toggleTheme(){
    if(_themeData == lightMode) {
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }
}