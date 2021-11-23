import 'package:flutter/material.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'Gluten': false,
    'Vegetarian': false,
    'Vegan': false,
    'Lactose': false
  };
  String _selectedMealId = '';

  void setSelectedMealId(String mealId) {
    _selectedMealId = mealId;
  }

  String get selectedMealId {
    return _selectedMealId;
  }

  List<Meal> avaliableMeals = DUMMY_MEALS;
  List<Category> avaliableCategory = [];
  List<Meal> favoriteMeals = [];
  List<String> prefsMealId = [];

  void setFilters(Map<String, bool> filterData) async {
    filters = filterData;
    avaliableMeals = DUMMY_MEALS.where((meal) {
      if (filters['Gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if (filters['Lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (filters['Vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      if (filters['Vegan']! && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();
    List<Category> ac = [];
    avaliableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if (cat.id == catId) {
            if (!ac.any((cat) => cat.id == catId)) {
              ac.add(cat);
            }
          }
        });
      });
    });
    avaliableCategory = ac;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('Gluten', filters['Gluten']!);
    pref.setBool('Lactose', filters['Lactose']!);
    pref.setBool('Vegan', filters['Vegan']!);
    pref.setBool('Vegetarian', filters['Vegetarian']!);
  }

  void setUserFilter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    filters['Gluten'] = pref.getBool(
          'Gluten',
        ) ??
        false;
    filters['Lactose'] = pref.getBool(
          'Lactose',
        ) ??
        false;
    filters['Vegan'] = pref.getBool('Vegan') ?? false;
    filters['Vegetarian'] = pref.getBool('Vegetarian') ?? false;
    prefsMealId = pref.getStringList('prefsMealId') ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }
    setFilters(filters);

    List<Meal> fm = [];
    favoriteMeals.forEach((favMeal) {
      avaliableMeals.forEach((avMeal) {
        if (favMeal.id == avMeal.id) fm.add(favMeal);
      });
      favoriteMeals = fm;
    });
    notifyListeners();
  }

  void toggleFavorites(String mealId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }

    notifyListeners();
    pref.setStringList('prefsMealId', prefsMealId);
  }

  bool isFavorite(mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }
}
