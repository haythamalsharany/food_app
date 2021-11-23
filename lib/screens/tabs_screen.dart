import 'package:flutter/material.dart';
import 'package:food_app/providers/language_provider.dart';
import 'package:food_app/providers/meal_provider.dart';
import 'package:food_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../screens/categoriesScreen.dart';
import '../screens/favorite_screen.dart';
import '../widgets/main_drawer.dart';

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> pages;

  @override
  void didChangeDependencies() {
    pages = [
      {
        'page': CategoriesScreen(),
        'title': Provider.of<LanguageProvider>(
          context,
        ).getTexts('tap_item1')
      },
      {
        'page': FavoriteScreen(),
        'title': Provider.of<LanguageProvider>(
          context,
        ).getTexts('your_favorites')
      }
    ];
    super.didChangeDependencies();
  }

  @override
  initState() {
    super.initState();
    Provider.of<MealProvider>(context, listen: false).setUserFilter();
    Provider.of<ThemeProvider>(context, listen: false).getPrefThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getPrefThemcolor();
    Provider.of<LanguageProvider>(context, listen: false).getLan();
  }

  int _selectedPageIndex = 0;

  void _selectedPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isEn = Provider.of<LanguageProvider>(context).isEn;
    return Directionality(
      textDirection: isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        //drawerEdgeDragWidth: 200,
        drawer: Drawer(child: MainDrawer()),
        appBar: AppBar(
          title: Text(pages[_selectedPageIndex]['title'].toString()),
        ),
        body: pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.white,
          backgroundColor: Theme.of(context).cardColor,
          onTap: _selectedPage,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: Provider.of<LanguageProvider>(
                context,
              ).getTexts('tap_item1').toString(),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: Provider.of<LanguageProvider>(
                  context,
                ).getTexts('tap_item2').toString())
          ],
        ),
      ),
    );
  }
}

class TabsScreen extends StatefulWidget {
  static const routeName = '/tab';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}
