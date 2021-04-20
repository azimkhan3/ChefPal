import 'package:chef_pal/recipe_search/recipe_list_widget.dart';
import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:chef_pal/recipe_search/recipe_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedRecipesView extends StatelessWidget {
  const SavedRecipesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedRecipes = Provider.of<List<Recipe>>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 12),
        child: Column(
          children: [
            Text(
              "Saved Recipes",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 15,
              ),
            ),
            RecipeListWidget(
              recipes: savedRecipes,
            )
          ],
        ),
      ),
    );
  }
}
