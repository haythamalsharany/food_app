// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:food_app/providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';
import '../providers/meal_provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'Meal_Detail_Screen';

  const MealDetailScreen({Key? key}) : super(key: key);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black),
        ));
  }

  Widget buildSectionList(BuildContext context, List<String> list) {
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      height: isLandscape ? (dh * 0.5) : (dh * 0.25),
      width: isLandscape ? dw * 0.45 : dw - 10,
      child: ListView.builder(
        itemBuilder: (_, index) => Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(list[index]),
          ),
          color: Theme.of(context).cardColor,
        ),
        itemCount: list.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mealId =
        Provider.of<MealProvider>(context, listen: false).selectedMealId;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    var isEn = Provider.of<LanguageProvider>(context).isEn;
    return Directionality(
        textDirection: isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title:
                      Text(lan.getTexts('meal-${selectedMeal.id}').toString()),
                  background: Hero(
                    tag: selectedMeal.id,
                    child: InteractiveViewer(
                      child: FadeInImage(
                        image: NetworkImage(selectedMeal.imageUrl),
                        placeholder: const AssetImage('assets/images/a1.png'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          buildSectionTitle(
                              context, lan.getTexts('Ingredients').toString()),
                          buildSectionList(
                              context,
                              lan.getTexts('ingredients-${selectedMeal.id}')
                                  as List<String>)
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          buildSectionTitle(
                              context, lan.getTexts('Steps').toString()),
                          buildSectionList(
                              context,
                              lan.getTexts('steps-${selectedMeal.id}')
                                  as List<String>)
                        ],
                      )
                    ],
                  ),
                if (!isLandscape)
                  buildSectionTitle(
                      context, lan.getTexts('Ingredients').toString()),
                if (!isLandscape)
                  buildSectionList(
                      context,
                      lan.getTexts('ingredients-${selectedMeal.id}')
                          as List<String>),
                if (!isLandscape)
                  buildSectionTitle(context, lan.getTexts('Steps').toString()),
                if (!isLandscape)
                  buildSectionList(context,
                      lan.getTexts('steps-${selectedMeal.id}') as List<String>)
              ]))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Provider.of<MealProvider>(context, listen: true)
                    .isFavorite(mealId)
                ? Icons.star
                : Icons.star_border),
            onPressed: () => Provider.of<MealProvider>(context, listen: false)
                .toggleFavorites(mealId),
          ),
        ));
  }
}
