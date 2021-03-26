import 'package:chef_pal/models/recipe_model.dart';
import 'package:chef_pal/services/spoonacular_api.dart';
import 'package:chef_pal/views/ui/ingredient_page/dropdown_widget.dart';
import 'package:chef_pal/views/ui/search_page/recipe_display.dart';
import 'package:flutter/material.dart';

class IngredientView extends StatefulWidget {
  IngredientView({Key key}) : super(key: key);

  @override
  _IngredientViewState createState() => _IngredientViewState();
}

class _IngredientViewState extends State<IngredientView> {
  List<Recipe> _recipes = [];
  List<String> _ingredients = ["cheese", "chicken", "mushrooms"];
  Map<String, List<String>> ingredientsMap = {
    "Dairy": ["Milk", "Egg", "Cheese"],
    "Meats": ["Chicken", "Beef"],
    "Spices": [],
    "Seafood": [],
    "Fruit": [],
    "Vegetables": [],
  };
  void _searchRecipe() async {
    List<Recipe> _recipesTemp =
        await ApiService.instance.generateRecipes(_ingredients);
    setState(() {
      _recipes = _recipesTemp;
      print('getting recipes');
    });
    // print(_recipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 48.0, left: 32.0, right: 32.0),
        child: Column(
          children: [
            Text("Ingredient Page"),
            CustomDropdown(
              text: "Dairy",
              ingredients: ingredientsMap["Dairy"],
            ),
            CustomDropdown(
              text: "Meats",
              ingredients: ingredientsMap["Meats"],
            ),
            CustomDropdown(
              text: "Spices",
              ingredients: ingredientsMap["Spices"],
            ),
            CustomDropdown(
              text: "Seafood",
              ingredients: ingredientsMap["Seafood"],
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
                  _searchRecipe();
                },
                child: Text(
                  "Search",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount: _recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      //color: Colors.amber[colorCodes[index]],
                      child: MaterialButton(
                        //color: Colors.orange.shade50,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 16,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.2,
                                  width:
                                      MediaQuery.of(context).size.height / 1.1,
                                  child: RecipeView(_recipes[index]),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          '${_recipes[index].title}',
                          style: TextStyle(
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        //Text("My Ingredients"),
        //Column(),
      ),
    );
  }
}
