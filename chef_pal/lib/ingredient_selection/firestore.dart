import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uid;
  FirestoreService(this.uid);

  //create user
  Future<void> initUser() async {
    Map<String, dynamic> ingredients = {
      'ingredients': {
        'Meat': {"Chicken": false, "Beef": false},
        'Seafood': {"Shrimp": false, "Salmon": false},
        'Vegetable': {"Carrots": false, "Onions": false},
      }
    };
    return await _db
        .collection('Users')
        .doc(this.uid)
        .set(ingredients)
        .then((value) => print('User created'))
        .catchError(
            (err) => print("Failed to create instance of user $uid : $err"));
  }

  //return map of ingredients to user
  Map<String, dynamic> _ingredientsFromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.get('ingredients'));
    return snapshot.get('ingredients');
  }

  //ingredient Stream
  Stream<Map<String, dynamic>> get ingredients {
    return _db
        .collection('Users')
        .doc(uid)
        .snapshots()
        .map(_ingredientsFromSnapshot);
  }

  //saved Recipe Stream
  Stream<List<Recipe>> get savedRecipes {
    return _db
        .collection('Users')
        .doc(uid)
        .collection('SavedRecipes')
        .snapshots()
        .map(_savedRecipesFromSnapshot);
  }

  //List Recipe
  List<Recipe> _savedRecipesFromSnapshot(QuerySnapshot snapshot) {
    List<Recipe> recipes = [];
    snapshot.docs.forEach((recipe) {
      recipes.add(Recipe(
        id: recipe.get('id'),
        title: recipe.get('title'),
        summary: recipe.get('summary'),
        imgLink: recipe.get('imgLink'),
      ));
    });

    return recipes;
  }

  //Stream of saved recipe ids
  Stream<List<int>> get savedRecipeIds {
    return _db
        .collection('Users')
        .doc(uid)
        .collection('SavedRecipes')
        .snapshots()
        .map(_savedRecipeIdsFromSnapshot);
  }

  //List recipeids
  List<int> _savedRecipeIdsFromSnapshot(QuerySnapshot snapshot) {
    List<int> recipeIds = [];
    snapshot.docs.forEach((doc) => recipeIds.add(int.parse(doc.id)));
    return recipeIds;
  }

  //update users inventory of ingredients
  Future<void> updateIngredients(Map<String, dynamic> data) async {
    return await _db
        .collection('Users')
        .doc(uid)
        .set({'ingredients': data})
        .then((value) => print("ingredients updated"))
        .catchError((err) => print(err));
  }

  Future<void> favoriteRecipe(Recipe recipe) async {
    //favoriteRecipeList(recipe);
    return await _db
        .collection('Users')
        .doc(uid)
        .collection('SavedRecipes')
        .doc(recipe.id.toString())
        .set(recipe.toMap())
        .then((value) => print('Favorited recipe: ${recipe.id}'))
        .catchError((err) => print(err));
  }

  Future<void> favoriteRecipeList(Recipe recipe, List<dynamic> recipes) async {
    return await _db
        .collection('Users')
        .doc(uid)
        .update(
          {
            'saved_recipe': [recipe.id]
          },
          // SetOptions(
          //   merge: true,
          // ),
        )
        .then((value) => print('Favorited recipe added to List: ${recipe.id}'))
        .catchError((err) => print(err));
  }
}
