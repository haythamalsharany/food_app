import 'package:flutter/material.dart';
import '../screens/categoryMealsScreen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext ctx) {
    Navigator.pushNamed(ctx, CategoryMealsScreen.routeName, arguments: {
      'id': id,
      'title': title
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme
          .of(context)
          .primaryColor,
      borderRadius: BorderRadius.circular(20.0),
      onTap: () {
        selectCategory(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: color,
            gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.6),
                  color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            ),

            borderRadius: BorderRadius.circular(20.0)
        ),
        padding: EdgeInsets.all(15),
        child: Text(title, style: Theme
            .of(context)
            .textTheme
            .headline6,),
      ),
    );
  }
}
