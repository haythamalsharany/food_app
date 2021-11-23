import 'package:flutter/material.dart';
import 'package:food_app/providers/language_provider.dart';
import 'package:food_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../widgets/mealItem.dart';

class FavoriteScreen extends StatelessWidget {
  late List<Meal> favoriteMeals;

  FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    favoriteMeals = Provider.of<MealProvider>(context).favoriteMeals;
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(lan.getTexts('favorites_text').toString()),
      );
    } else {
      return GridView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(favoriteMeals[index]);
        },
        itemCount: favoriteMeals.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: dw <= 400 ? 400 : 500,
          childAspectRatio: isLandscape ? dw / (dw * 0.8) : dw / (dw * 0.754),
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
      );
    }
  }
}
