import 'package:chef_pal/models/recipe_model.dart';
import 'package:chef_pal/services/spoonacular_api.dart';
import 'package:flutter/material.dart';

class RecipeView extends StatelessWidget {
  final Recipe _recipe;
  const RecipeView(this._recipe);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            _recipe.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
