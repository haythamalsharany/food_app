// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:food_app/providers/language_provider.dart';
import 'package:food_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/categoriesItem.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = 'category';

  @override
  Widget build(BuildContext context) {
    var isEn = Provider.of<LanguageProvider>(context).isEn;
    return Directionality(
        textDirection: isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          /*  appBar: AppBar(
          title: Text(
            'Meal App',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),*/
          body: GridView(
              padding: EdgeInsets.all(25),
              children: Provider.of<MealProvider>(context)
                  .avaliableCategory
                  .map((catData) => CategoryItem(
                      catData.id,
                      Provider.of<LanguageProvider>(
                        context,
                      ).getTexts('cat-${catData.id}').toString(),
                      catData.color))
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              )),
        ));
  }
}
