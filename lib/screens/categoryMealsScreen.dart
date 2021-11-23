// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:food_app/providers/language_provider.dart';
import 'package:food_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../widgets/mealItem.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late final List<Meal> avaliableMeals;

  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    avaliableMeals =
        Provider.of<MealProvider>(context, listen: true).avaliableMeals;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;

    final categoryId = routeArg['id'];
    final categoryTitle = routeArg['title'];
    final categoryMeals = avaliableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    var isEn = Provider.of<LanguageProvider>(context).isEn;
    return Directionality(
        textDirection: isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                categoryTitle!,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: GridView.builder(
              itemBuilder: (ctx, index) {
                return MealItem(categoryMeals[index]);
              },
              itemCount: categoryMeals.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: dw <= 400 ? 400 : 500,
                childAspectRatio:
                    isLandscape ? dw / (dw * 0.8) : dw / (dw * 0.75),
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
            )));
  }
}
