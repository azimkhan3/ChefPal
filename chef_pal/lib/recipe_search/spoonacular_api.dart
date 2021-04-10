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
  //static const String API_KEY = "a6ce9d76a0cb413cab0c9b5a8636407c";
  static const String API_KEY = "30f86d0d42554f14aa08180f664db122";
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
      print(data.entries.first.value.runtimeType);

      List<Recipe> recipes = [];
      List<RecipeStep> stepList;
      List<RecipeIngredient> tempIngredients;
      List<String> ingredientsList;
      // data.entries.first.value
      //     .forEach((recipeMap) => print(recipeMap['extendedIngredients']));
      for (dynamic recipe in data.entries.first.value) {
        stepList = [];
        tempIngredients = [];
        for (dynamic step in recipe['analyzedInstructions'][0]['steps']) {
          ingredientsList = [];
          for (dynamic ingredient in step['ingredients']) {
            if (ingredient['name'] != null) {
              ingredientsList.add(ingredient['name']);
            }
          }
          stepList.add(
            RecipeStep(
              number: step['number'],
              step: step['step'],
              ingredients: ingredientsList,
            ),
          );
        }
        for (dynamic ingredient in recipe['extendedIngredients']) {
          tempIngredients.add(
            RecipeIngredient(
              name: ingredient['name'],
              original: ingredient['original'],
              units: ingredient['unit'],
              amount: ingredient['amount'],
            ),
          );
        }
        recipes.add(
          Recipe(
            id: recipe['id'],
            title: recipe['title'],
            summary: recipe['summary'],
            steps: stepList,
            ingredients: tempIngredients,
            imgLink: recipe['image'],
          ),
        );
      }
      return recipes;
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }

  // Future<Recipe> fetchRecipe(String id) async {
  //   Map<String, String> parameters = {
  //     'includeNutrition': 'false',
  //     'apiKey': API_KEY,
  //   };

  //   //we call in our recipe id in the Uri, and parse in our parameters
  //   Uri uri = Uri.https(
  //     _baseURL,
  //     '/recipes/$id/information',
  //     parameters,
  //   );

  //   //And also specify that we want our header to return a json object
  //   Map<String, String> headers = {
  //     HttpHeaders.contentTypeHeader: 'application/json',
  //   };

  //   //finally, we put our response in a try catch block
  //   try {
  //     var response = await http.get(uri, headers: headers);
  //     Map<String, dynamic> data = json.decode(response.body);
  //     print(data);
  //     return null;
  //   } catch (err) {
  //     throw err.toString();
  //   }
  // }

  Future<List<Recipe>> generateRecipes(List<String> ingredients) async {
    print(ingredients);
    Map<String, String> parameters = {
      'ingredients': ingredients
          .toString()
          .substring(1, ingredients.toString().length - 1),
      'number': '5',
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

      List<Recipe> recipes = [];
      for (dynamic recipe in data) {
        recipes.add(
          Recipe(
            id: recipe['id'],
            title: recipe['title'],
            summary: "",
            steps: [],
            ingredients: [],
            imgLink: recipe['image'],
          ),
        );
      }
      print(data.first['id']);
      // data.forEach((recipeMap) => print(recipeMap.toString()));
      return recipes;
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }
}
