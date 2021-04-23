import 'package:chef_pal/profile/user_model.dart';
import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uid;
  FirestoreService(this.uid);

  //create user
  Future<void> initUser(String username) async {
    Map<String, dynamic> userData = {
      'username': username,
      'ingredients': {
        'Meat': {"Chicken": false, "Beef": false},
        'Seafood': {"Shrimp": false, "Salmon": false},
        'Vegetable': {"Carrots": false, "Onions": false},
      },
      'diet': null,
      'intolerences': {
        'Dairy': false,
        'Egg': false,
        'Gluten': false,
        'Grain': false,
        'Peanut': false,
        'Seafood': false,
        'Sesame': false,
        'Shellfish': false,
        'Soy': false,
        'Sulfite': false,
        'Tree Nut': false,
        'Wheat': false,
      },
    };

    return await _db
        .collection('Users')
        .doc(this.uid)
        .set(userData)
        .then((value) => print('User created'))
        .catchError(
            (err) => print("Failed to create instance of user $uid : $err"));
  }

  //return map of userdata
  UserData _userdataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid.toString(),
      username: snapshot.get('username'),
      diet: snapshot.get('diet'),
      intolerences: snapshot.get('intolerences'),
    );
  }

  //UserData Stream
  Stream<UserData> get userdata {
    return _db
        .collection('Users')
        .doc(uid)
        .snapshots()
        .map(_userdataFromSnapshot);
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
    List<RecipeIngredient> recipeIngredients;
    List<RecipeStep> recipeSteps;
    try {
      snapshot.docs.forEach((recipe) {
        recipeIngredients = [];
        recipeSteps = [];

        List<dynamic> stepsData = recipe.get('steps');
        stepsData.forEach((step) {
          recipeSteps.add(
            RecipeStep(
              number: step['number'],
              step: step['step'],
              ingredients:
                  step['ingredients'].cast<String>(), //fix this  type error
            ),
          );
        });

        List<dynamic> ingredientsData = recipe.get('ingredients');
        ingredientsData.forEach((ingredient) {
          recipeIngredients.add(
            RecipeIngredient(
              amount: double.parse(ingredient['amount'].toString()),
              name: ingredient['name'],
              original: ingredient['original'],
              units: ingredient['units'],
            ),
          );
        });

        recipes.add(
          Recipe(
            id: recipe.get('id'),
            title: recipe.get('title'),
            readyInMinutes: recipe.get('readyInMinutes'),
            summary: recipe.get('summary'),
            steps: recipeSteps,
            ingredients: recipeIngredients,
            imgLink: recipe.get('imgLink'),
            vegetarian: recipe.get('vegetarian'),
            vegan: recipe.get('vegan'),
            glutenFree: recipe.get('glutenFree'),
            dairyFree: recipe.get('dairyFree'),
            veryHealthy: recipe.get('veryHealthy'),
            cheap: recipe.get('cheap'),
            veryPopular: recipe.get('veryPopular'),
            sustainable: recipe.get('sustainable'),
          ),
        );
      });
    } catch (err) {
      throw err.toString();
    }

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

  Future<void> unfavoriteRecipe(Recipe recipe) async {
    //favoriteRecipeList(recipe);
    return await _db
        .collection('Users')
        .doc(uid)
        .collection('SavedRecipes')
        .doc(recipe.id.toString())
        .delete()
        .then((value) => print('unfavorited recipe: ${recipe.id}'))
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
