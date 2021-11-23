import 'package:flutter/material.dart';
import 'package:food_app/providers/language_provider.dart';
import 'package:food_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = 'Filter_screen';
  bool? fromOnBoarding;

  FilterScreen({Key? key, this.fromOnBoarding = false}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  //late final Function saveFilter;

  @override
  initState() {
    super.initState();
  }

  Widget buildSwitchListTitle(String title, String describtion,
      bool currentValue, Function(bool)? updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(describtion),
        value: currentValue,
        onChanged: (val) => updateValue!(val));
  }

  @override
  Widget build(BuildContext context) {
    Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;
    var lan = Provider.of<LanguageProvider>(context);
    var isEn = lan.isEn;
    return Directionality(
        textDirection: isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                title: widget.fromOnBoarding!
                    ? null
                    : Text(lan.getTexts('filters_appBar_title').toString()),
                backgroundColor: widget.fromOnBoarding!
                    ? Theme.of(context).canvasColor
                    : Theme.of(context).primaryColor,
                elevation: widget.fromOnBoarding! ? 0 : 5,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    lan.getTexts('filters_screen_title').toString(),
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                buildSwitchListTitle(
                    lan.getTexts('Gluten-free').toString(),
                    lan.getTexts('Gluten-free-sub').toString(),
                    currentFilters['Gluten']!, (newValue) {
                  setState(() {
                    currentFilters['Gluten'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters(currentFilters);
                }),
                buildSwitchListTitle(
                    lan.getTexts('Lactose-free').toString(),
                    lan.getTexts('Lactose-free_sub').toString(),
                    currentFilters['Lactose']!, (newValue) {
                  setState(() {
                    currentFilters['Lactose'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters(currentFilters);
                }),
                buildSwitchListTitle(
                    lan.getTexts('Vegan').toString(),
                    lan.getTexts('Vegan-sub').toString(),
                    currentFilters['Vegan']!, (newValue) {
                  setState(() {
                    currentFilters['Vegan'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters(currentFilters);
                }),
                buildSwitchListTitle(
                    lan.getTexts('Vegetarian').toString(),
                    lan.getTexts('Vegetarian-sub').toString(),
                    currentFilters['Vegetarian']!, (newValue) {
                  setState(() {
                    currentFilters['Vegetarian'] = newValue;
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters(currentFilters);
                  });
                }),
                SizedBox(height: widget.fromOnBoarding! ? 80 : 0)
              ]))
            ],
          ),
          drawer: widget.fromOnBoarding! ? null : MainDrawer(),
        ));
  }
}
