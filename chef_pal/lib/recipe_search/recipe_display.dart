import 'dart:ui';
import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:flutter/material.dart';

class RecipeView extends StatelessWidget {
  final Recipe _recipe;
  const RecipeView(this._recipe);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 55,
          horizontal: MediaQuery.of(context).size.width / 55,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _recipe.title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            //if (_recipe.imgLink.length > 0) Image.network(_recipe.imgLink),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 55,
              ),
              child: Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IngredientDisplay(_recipe),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 55,
              ),
              child: Text(
                "Steps",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StepsDisplay(_recipe.steps),
          ],
        ),
      ),
    );
  }
}

class RecipeTags extends StatelessWidget {
  final _recipe;
  const RecipeTags(this._recipe);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [],
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    _recipe.ingredients[index].name,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 55,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  children: [
                    Text('${_recipe.ingredients[index].amount} '),
                    Text('${_recipe.ingredients[index].units}'),
                  ],
                ),
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
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step: ${_steps[index].number} ',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 55,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                  Text('${_steps[index].step} ')
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
