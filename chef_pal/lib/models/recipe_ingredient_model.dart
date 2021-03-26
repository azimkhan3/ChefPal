class RecipeIngredient {
  final String name, units, original;
  final double amount;

  RecipeIngredient({this.name, this.original, this.units, this.amount});

  factory RecipeIngredient.fromMap(Map<String, dynamic> map) {
    return RecipeIngredient(
      name: map['name'],
      original: map['original'],
      units: map['units'],
      amount: map['amount'],
    );
  }
}
