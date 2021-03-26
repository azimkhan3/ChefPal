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
