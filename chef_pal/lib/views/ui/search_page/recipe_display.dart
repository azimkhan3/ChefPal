import 'dart:ui';
import 'package:chef_pal/models/recipe_model.dart';
import 'package:chef_pal/models/recipe_steps_model.dart';
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
          ),
          if (_recipe.imgLink.length > 0) Image.network(_recipe.imgLink),
          IngredientDisplay(_recipe),
          StepsDisplay(_recipe.steps),
        ],
      ),
    );
  }
}

class IngredientDisplay extends StatelessWidget {
  final Recipe _recipe;
  const IngredientDisplay(this._recipe);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          itemCount: _recipe.ingredients.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(_recipe.ingredients[index].name),
                ),
                Text('${_recipe.ingredients[index].amount} '),
                Text('${_recipe.ingredients[index].units}'),
              ],
            );
          },
        ),
      ),
    );
  }
}

class StepsDisplay extends StatelessWidget {
  final List<RecipeStep> _steps;
  const StepsDisplay(this._steps);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          itemCount: _steps.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Text('${_steps[index].number} '),
                Text('${_steps[index].step} ')
              ],
            );
          },
        ),
      ),
    );
  }
}
