import 'package:chef_pal/models/recipe_ingredient_model.dart';
import 'package:chef_pal/models/recipe_steps_model.dart';

class Recipe {
  final int id;
  final String title, summary;
  final List<RecipeStep> steps;
  final List<RecipeIngredient> ingredients;

  Recipe({
    this.id,
    this.title,
    this.summary,
    this.steps,
    this.ingredients,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    //Recipe Object
    List<RecipeStep> tempSteps = [];
    map['analyzedInstructions'][0]['steps'].forEach(
      (step) => tempSteps.add(
        RecipeStep.fromMap(step),
      ),
    );
    List<RecipeIngredient> tempIngredients = [];
    map['extendedIngredients'].forEach(
      (ingredient) => tempIngredients.add(
        RecipeIngredient.fromMap(ingredient),
      ),
    );
    return Recipe(
      id: map['id'],
      title: map['title'],
      summary: map['summary'],
      steps: tempSteps,
      ingredients: tempIngredients,
    );
  }
}
