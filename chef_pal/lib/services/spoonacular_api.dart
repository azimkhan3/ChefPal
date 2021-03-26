import 'dart:convert';
import 'dart:io';
import 'package:chef_pal/models/recipe_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //The API service will be a singleton, therefore create a private constructor
  //ApiService._instantiate(), and a static instance variable
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();
  //Add base URL for the spoonacular API, endpoint and API Key as a constant
  final String _baseURL = "api.spoonacular.com";
  static const String API_KEY = "a6ce9d76a0cb413cab0c9b5a8636407c";
  //We create async function to generate meal plan which takes in
  //timeFrame, targetCalories, diet and apiKey
  //If diet is none, we set the diet into an empty string
  //timeFrame parameter sets our meals into 3 meals, which are daily meals.
  //that's why it's set to day
  Future<List<Recipe>> searchRecipes(String query) async {
    Map<String, String> parameters = {
      'query': query,
      'fillIngredients': 'true',
      'instructionsRequired': 'true',
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

      List<Recipe> recipes = [];

      data['results']
          .forEach((recipeMap) => recipes.add(Recipe.fromMap(recipeMap)));
      return recipes;
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }

  Future<List<Recipe>> generateRecipes(List<String> ingredients) async {
    Map<String, String> parameters = {
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
  }
}
