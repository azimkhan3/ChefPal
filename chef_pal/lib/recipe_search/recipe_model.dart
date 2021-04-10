class Recipe {
  final int id;
  final String title, summary, imgLink;
  final List<RecipeStep> steps;
  final List<RecipeIngredient> ingredients;

  Recipe({
    this.id,
    this.title,
    this.summary = "",
    this.steps,
    this.ingredients,
    this.imgLink = "",
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    //Recipe Object
    List<RecipeStep> tempSteps = [];
    // map['analyzedInstructions'][0]['steps'].forEach(
    //   (step) => tempSteps.add(
    //     RecipeStep.fromMap(step),
    //   ),
    // );
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

class RecipeIngredient {
  final String name, units, original;
  final double amount;

  RecipeIngredient({
    this.name,
    this.original = "",
    this.units = "",
    this.amount = 0.0,
  });

  factory RecipeIngredient.fromMap(Map<String, dynamic> map) {
    return RecipeIngredient(
      name: map['name'],
      original: map['original'],
      units: map['units'],
      amount: map['amount'],
    );
  }
}

class RecipeStep {
  final int number;
  final String step;
  final List<String> ingredients;

  RecipeStep({this.number, this.step, this.ingredients});

  factory RecipeStep.fromMap(Map<String, dynamic> map) {
    List<String> usedIngredients = [];
    map['steps'].forEach(
      (step) => step['ingredients'].forEach(
        (ingredient) => usedIngredients.add(ingredient),
      ),
    );
    return RecipeStep(
      number: map['number'],
      step: map['step'],
      ingredients: map["ingredients"],
    );
  }
}
