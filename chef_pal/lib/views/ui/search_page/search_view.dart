import 'package:chef_pal/models/recipe_model.dart';
import 'package:chef_pal/services/spoonacular_api.dart';
import 'package:chef_pal/views/ui/search_page/recipe_display.dart';
import 'package:chef_pal/views/ui/search_page/recipe_search_widget.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _searchField = TextEditingController();
  List<Recipe> _recipes = [];
  void _searchRecipe() async {
    List<Recipe> _recipesTemp =
        await ApiService.instance.searchRecipes(_searchField.text);
    setState(() {
      _recipes = _recipesTemp;
      print('getting recipes');
    });
    // print(_recipes);
  }

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
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
                                    height: MediaQuery.of(context).size.height /
                                        1.2,
                                    width: MediaQuery.of(context).size.height /
                                        1.1,
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
        ),
      ),
    );
  }
}
