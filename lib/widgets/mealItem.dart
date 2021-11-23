// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/providers/language_provider.dart';
import 'package:food_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../screens/mealDetailScreen.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem(this.meal);

  String mealComplexityText(BuildContext ctx) {
    switch (meal.complexity) {
      case Complexity.Simple:
        return Provider.of<LanguageProvider>(
          ctx,
        ).getTexts('Complexity.Simple').toString();
        break;
      case Complexity.Challenging:
        return Provider.of<LanguageProvider>(
          ctx,
        ).getTexts('Complexity.Challenging').toString();
        break;
      case Complexity.Hard:
        return Provider.of<LanguageProvider>(
          ctx,
        ).getTexts('Complexity.Hard').toString();
        break;
      default:
        return 'UnKnown';
    }
  }

  String mealAffordabilityText(BuildContext ctx) {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return Provider.of<LanguageProvider>(
          ctx,
        ).getTexts('Affordability.Affordable').toString();
      case Affordability.Luxurious:
        return Provider.of<LanguageProvider>(
          ctx,
        ).getTexts('Affordability.Luxurious').toString();
      case Affordability.Pricey:
        return Provider.of<LanguageProvider>(
          ctx,
        ).getTexts('Affordability.Pricey').toString();
      default:
        return 'Unknown';
    }
  }

  void selectedMeal(BuildContext ctx) {
    Provider.of<MealProvider>(ctx, listen: false).setSelectedMealId(meal.id);
    Navigator.of(ctx).pushNamed(MealDetailScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedMeal(context),
      child: Card(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Hero(
                      tag: meal.id,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          image: NetworkImage(meal.imageUrl),
                          placeholder: const AssetImage('assets/images/a1.png'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    color: Colors.black54,
                    width: 300,
                    child: Text(
                      Provider.of<LanguageProvider>(context)
                          .getTexts('meal-${meal.id}')
                          .toString(),
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '${meal.duration}',
                        style: TextStyle(
                            color:
                            Theme
                                .of(context)
                                .textTheme
                                .bodyText2!
                                .color),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(mealComplexityText(context))
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(mealAffordabilityText(context))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
      ),
    );
  }
}
