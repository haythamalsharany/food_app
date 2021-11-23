import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:food_app/providers/language_provider.dart';
import 'package:food_app/providers/theme_provider.dart';
import 'package:food_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  static const routeName = '/theme';
  bool? fromOnBoarding;

  ThemeScreen({Key? key, this.fromOnBoarding = false}) : super(key: key);

  Widget buildRadioListTile(
    ThemeMode themeVal,
    String txt,
    IconData icon,
    BuildContext ctx,
  ) {
    return RadioListTile(
      //activeColor: ,

      secondary: Icon(
        icon,
      ),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
      onChanged: (val) {
        Provider.of<ThemeProvider>(ctx, listen: false).themeModeChange(val);
      },
      title: Text(txt),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    var isEn = lan.isEn;
    return Directionality(
        textDirection: isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                title: fromOnBoarding!
                    ? null
                    : Text(lan.getTexts('theme_appBar_title').toString()),
                backgroundColor: fromOnBoarding!
                    ? Theme.of(context).canvasColor
                    : Theme.of(context).primaryColor,
                elevation: fromOnBoarding! ? 0 : 5,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        lan.getTexts('theme_screen_title').toString(),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    buildRadioListTile(
                        ThemeMode.system,
                        lan.getTexts('System_default_theme').toString(),
                        Icons.thirty_fps_select_rounded,
                        context),
                    buildRadioListTile(
                        ThemeMode.light,
                        lan.getTexts('light_theme').toString(),
                        Icons.wb_sunny_outlined,
                        context),
                    buildRadioListTile(
                        ThemeMode.dark,
                        lan.getTexts('dark_theme').toString(),
                        Icons.nightlight_round,
                        context),
                    buildListTile(
                        context, lan.getTexts('primary').toString(), 'primary'),
                    buildListTile(
                        context, lan.getTexts('accent').toString(), 'accent'),
                    SizedBox(height: fromOnBoarding! ? 80 : 0)
                  ],
                ),
              ),
            ],
          ),
          drawer: fromOnBoarding! ? null : MainDrawer(),
        ));
  }

  buildListTile(BuildContext context, text, key) {
    MaterialColor primaryColor =
        Provider.of<ThemeProvider>(context).primarColor;
    MaterialColor secondryColor =
        Provider.of<ThemeProvider>(context).secondryColor;
    var lan = Provider.of<LanguageProvider>(context);
    return ListTile(
      title: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: text ==
                Provider.of<LanguageProvider>(context)
                    .getTexts('primary')
                    .toString()
            ? primaryColor
            : secondryColor,
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                  elevation: 4,
                  titlePadding: const EdgeInsets.all(0.0),
                  contentPadding: const EdgeInsets.all(0.0),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: key == 'primary'
                          ? Provider.of<ThemeProvider>(context).primarColor
                          : Provider.of<ThemeProvider>(context).secondryColor,
                      onColorChanged: (newVal) =>
                          Provider.of<ThemeProvider>(context, listen: false)
                              .onChangeed(newVal, key == 'primary' ? 1 : 2),
                      colorPickerWidth: 300,
                      pickerAreaHeightPercent: 0.7,
                      enableAlpha: false,
                      displayThumbColor: true,
                      showLabel: false,
                    ),
                  ));
            });
      },
    );
  }
}
