import 'package:chef_pal/recipe_search/recipe_display.dart';
import 'package:chef_pal/recipe_search/recipe_list_widget.dart';
import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:chef_pal/recipe_search/recipe_preview.dart';
import 'package:chef_pal/recipe_search/spoonacular_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResult with ChangeNotifier {
  List<Recipe> recipes = [];
  void setRecipes(String search) async {
    recipes = await ApiService.instance.searchRecipes(search);
    notifyListeners();
  }

  void ingredientSearch(Map<String, dynamic> ingredientsMap) async {
    List<String> ingredients = [];
    ingredientsMap.forEach((category, value) {
      value.forEach((ingredient, status) {
        if (status) ingredients.add(ingredient);
      });
    });
    print(ingredients);
    recipes = await ApiService.instance.generateRecipes(ingredients);
    notifyListeners();
  }
}

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<SearchResult>(
        create: (context) => SearchResult(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SearchBar(),
                RecipeSearchDisplay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeSearchDisplay extends StatelessWidget {
  const RecipeSearchDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchResult>(
      builder: (_, recipes, __) => RecipeListWidget(
        recipes: recipes.recipes,
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchField = TextEditingController();
    final recipes = Provider.of<SearchResult>(context, listen: false);
    final ingredients = Provider.of<Map<String, dynamic>>(context);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextFormField(
            style: TextStyle(color: Colors.grey.shade700),
            controller: _searchField,
            decoration: InputDecoration(
              labelText: "Search all Recipes",
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: MaterialButton(
            color: Colors.orange.shade400,
            onPressed: () async {
              recipes.setRecipes(_searchField.text);
            },
            child: Text(
              "Search",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: MaterialButton(
            color: Colors.orange.shade400,
            onPressed: () async {
              print(ingredients);
              recipes.ingredientSearch(ingredients);
            },
            child: Text(
              "Ingredient Based Search",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
