import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:food_app/providers/language_provider.dart';
import 'package:food_app/providers/theme_provider.dart';
import 'package:food_app/screens/tabs_screen.dart';
import 'package:food_app/screens/theme_screen.dart';
import 'package:provider/provider.dart';

import '../screens/fillter_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function? tabHandler,
      BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme
            .of(ctx)
            .textTheme
            .bodyText1!
            .color,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: Theme
                .of(ctx)
                .textTheme
                .bodyText1!
                .color,
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold),
      ),
      onTap: () => tabHandler!(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: false);
    return ListView(
      children: [
        Container(
          height: 150,
          color: Theme
              .of(context)
              .colorScheme
              .secondary,
          child: Center(
            child: Text(
              lan.getTexts('drawer_name').toString(),
              style: TextStyle(
                  color: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .color,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
        ),
        buildListTile(lan.getTexts('drawer_item1').toString(), Icons.restaurant,
                () {
              Navigator.of(context).pushNamed(TabsScreen.routeName);
            }, context),
        buildListTile(lan.getTexts('drawer_item2').toString(), Icons.settings,
                () {
              Navigator.of(context).pushNamed(FilterScreen.routeName);
            }, context),
        buildListTile(
            lan.getTexts('drawer_item3').toString(), Icons.nightlight_round,
                () {
              Navigator.of(context).pushNamed(ThemeScreen.routeName);
            }, context),
        const Divider(
          height: 20,
          color: Colors.black54,
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(top: 20, right: 20),
          child: Text(
            lan.getTexts('drawer_switch_title').toString(),
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: lan.isEn ? 0 : 20, left: lan.isEn ? 20 : 0, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                lan.getTexts('drawer_switch_item2').toString(),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
              Switch(
                value: Provider
                    .of<LanguageProvider>(
                  context,
                )
                    .isEn,
                onChanged: (newValue) {
                  lan.changeLan(newValue);
                  Navigator.of(context).pop();
                },
                inactiveTrackColor: Provider
                    .of<ThemeProvider>(
                  context,
                )
                    .tm ==
                    ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                activeColor: Provider
                    .of<ThemeProvider>(
                  context,
                )
                    .tm ==
                    ThemeMode.dark
                    ? Colors.black
                    : Colors.white,
              ),
              Text(
                lan.getTexts('drawer_switch_item1').toString(),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              )
            ],
          ),
        ),
        const Divider(
          height: 20,
          color: Colors.black54,
        ),
      ],
    );
  }
}
