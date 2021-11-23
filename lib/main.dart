import 'package:flutter/material.dart';
import 'package:food_app/providers/language_provider.dart';
import 'package:food_app/providers/meal_provider.dart';
import 'package:food_app/providers/theme_provider.dart';
import 'package:food_app/screens/on_boarding_screen.dart';
import 'package:food_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/categoryMealsScreen.dart';
import './screens/fillter_screen.dart';
import './screens/mealDetailScreen.dart';
import './screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen = prefs.getBool('watched') ?? false
      ? const TabsScreen()
      : const OnBoardingScreen();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MealProvider>(
        create: (ctx) => MealProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(
        create: (ctx) => ThemeProvider(),
      ),
      ChangeNotifierProvider<LanguageProvider>(
        create: (ctx) => LanguageProvider(),
      ),
    ],
    child: MyApp(
      meanScreen: homeScreen,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final Widget meanScreen;

  MyApp({Key? key, required this.meanScreen}) : super(key: key);

  Widget build(BuildContext context) {
    MaterialColor primaryColor =
        Provider
            .of<ThemeProvider>(context)
            .primarColor;
    MaterialColor secondryColor =
        Provider
            .of<ThemeProvider>(context)
            .secondryColor;
    ThemeMode tm = Provider
        .of<ThemeProvider>(context)
        .tm;
    return MaterialApp(
        title: 'Flutter Demo',
        themeMode: tm,
        theme: ThemeData(
            fontFamily: 'Ralway',
            canvasColor: const Color.fromRGBO(230, 150, 220, 1),
            cardColor: const Color.fromRGBO(220, 220, 100, 1),
            shadowColor: Colors.black38,
            textTheme: ThemeData
                .light()
                .textTheme
                .copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(30, 35, 30, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(90, 80, 100, 1),
                ),
                headline6: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold)),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
                .copyWith(secondary: secondryColor)),
        darkTheme: ThemeData(
            fontFamily: 'Ralway',
            canvasColor: const Color.fromRGBO(30, 0, 30, 1),
            cardColor: const Color.fromRGBO(35, 34, 39, 1),
            unselectedWidgetColor: Colors.white70,
            shadowColor: Colors.white60,
            textTheme: ThemeData
                .dark()
                .textTheme
                .copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(10, 100, 100, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(200, 200, 150, 1),
                ),
                headline6: const TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold)),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor)
                .copyWith(secondary: secondryColor)),

        //  home: const TabsScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => meanScreen,
          TabsScreen.routeName: (context) => const TabsScreen(),
          CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
          FilterScreen.routeName: (context) => FilterScreen(),
          MealDetailScreen.routeName: (context) => const MealDetailScreen(),
          ThemeScreen.routeName: (context) => ThemeScreen(),
        });
  }
}
