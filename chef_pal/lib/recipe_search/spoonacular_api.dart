import 'dart:convert';
import 'dart:io';
import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //The API service will be a singleton, therefore create a private constructor
  //ApiService._instantiate(), and a static instance variable
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();
  //Add base URL for the spoonacular API, endpoint and API Key as a constant
  final String _baseURL = "api.spoonacular.com";
  static const String API_KEY = "a6ce9d76a0cb413cab0c9b5a8636407c";
  // static const String API_KEY = "30f86d0d42554f14aa08180f664db122";
  //a26b1f378c714d9d95f0df0f2997e14c
  //ebd26db4189b436f9bd66117e3e8699c
  Future<List<Recipe>> searchRecipes(String query) async {
    Map<String, String> parameters = {
      'query': query,
      'number': '15',
      'fillIngredients': true.toString(),
      'instructionsRequired': true.toString(),
      'addRecipeInformation': true.toString(),
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseURL,
      '/recipes/complexSearch',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //http.get to retrieve the response
      var response = await http.get(uri, headers: headers);
      //decode the body of the response into a map
      Map<String, dynamic> data = json.decode(response.body);
      // print(data.entries.first.value);

      List<Recipe> recipes = [];
      List<RecipeStep> stepList;
      List<RecipeIngredient> tempIngredients;
      List<String> ingredientsList;
      // data.entries.first.value
      //     .forEach((recipeMap) => print(recipeMap['extendedIngredients']));

      for (dynamic recipe in data.entries.first.value) {
        // if (recipe['instructions'] == null) continue;
        // if (recipe['analyzedInstructions'].toString() == '[]') continue;
        recipes.add(extractRecipe(recipe));
      }
      print(recipes.length);
      return recipes;
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }

  Future<List<Recipe>> generateRecipes(List<String> ingredients) async {
    // print(ingredients);
    Map<String, String> parameters = {
      'ingredients': ingredients
          .toString()
          .substring(1, ingredients.toString().length - 1)
          .replaceAll(new RegExp(r"\s+"), ""),
      'number': '10',
      'limitLicense': true.toString(),
      'ranking': '1',
      'ignorePantry': true.toString(),
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseURL,
      '/recipes/findByIngredients',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //http.get to retrieve the response
      var response = await http.get(uri, headers: headers);
      //decode the body of the response into a map
      List<dynamic> data = json.decode(response.body);

      List<String> recipeIds = [];
      data.forEach((recipe) {
        recipeIds.add(recipe['id'].toString());
      });

      // print(data.first['id']);
      // data.forEach((recipeMap) => print(recipeMap.toString()));
      return recipeIds.length > 0 ? getRecipeInformationBulk(recipeIds) : [];
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }

  Future<List<Recipe>> getRecipeInformationBulk(List<String> recipeIds) async {
    // print(recipeIds.toString());
    Map<String, String> parameters = {
      'ids': recipeIds
          .toString()
          .substring(1, recipeIds.toString().length - 1)
          .replaceAll(new RegExp(r"\s+"), ""),
      'includeNutrition': false.toString(),
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseURL,
      '/recipes/informationBulk',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //http.get to retrieve the response
      var response = await http.get(uri, headers: headers);
      //decode the body of the response into a map
      // print(recipeIds
      //     .toString()
      //     .substring(1, recipeIds.toString().length - 1)
      //     .replaceAll(new RegExp(r"\s+"), ""));
      List<dynamic> data = json.decode(response.body);

      List<Recipe> recipes = [];
      // print(data.length);
      for (dynamic recipe in data) {
        if (recipe['instructions'] == null) continue;
        if (recipe['analyzedInstructions'].toString() == '[]') continue;
        recipes.add(extractRecipe(recipe));
      }

      return recipes;
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }

  Recipe extractRecipe(dynamic recipe) {
    // if (recipe['instructions'] == null) return null;
    // Recipe recipe;
    List<RecipeStep> stepList = [];
    List<RecipeIngredient> tempIngredients = [];
    List<String> ingredientsList = [];
    // ignore recipe if id doesnt have instructions

    // print(recipe['analyzedInstructions']);
    for (dynamic step in recipe['analyzedInstructions'][0]['steps']) {
      // get ingredients used in each step
      ingredientsList = [];
      for (dynamic ingredient in step['ingredients']) {
        if (ingredient['name'] != null) {
          ingredientsList.add(ingredient['name']);
        }
      }
      // add recipe step to the list of recipe steps
      // keep track of step number what to do and ingredients
      stepList.add(
        RecipeStep(
          number: step['number'],
          step: step['step'],
          ingredients: ingredientsList,
        ),
      );
    }
    for (dynamic ingredient in recipe['extendedIngredients']) {
      //add ingredients to list of RecipeIngredients
      tempIngredients.add(
        RecipeIngredient(
          name: ingredient['name'],
          original: ingredient['original'],
          units: ingredient['unit'],
          amount: ingredient['amount'],
        ),
      );
    }
    return Recipe(
      id: recipe['id'],
      title: recipe['title'],
      readyInMinutes: recipe['readyInMinutes'],
      // summary: recipe['summary'],
      steps: stepList,
      ingredients: tempIngredients,
      imgLink: recipe['image'],
      vegetarian: recipe['vegetarian'],
      vegan: recipe['vegan'],
      glutenFree: recipe['glutenFree'],
      dairyFree: recipe['dairyFree'],
      veryHealthy: recipe['veryHealthy'],
      cheap: recipe['cheap'],
      veryPopular: recipe['veryPopular'],
      sustainable: recipe['sustainable'],
      // cuisines: recipe['cuisines'].length > 0
      //     ? recipe['cuisines'].Cast<String>().ToList()
      //     : [],
      // dishTypes: recipe['dishTypes'].length > 0
      //     ? recipe['dishTypes'].Cast<String>().ToList()
      //     : [],
      // diets: recipe['diets'].length > 0
      //     ? recipe['diets'].Cast<String>().ToList()
      //     : [],
    );
  }
}
