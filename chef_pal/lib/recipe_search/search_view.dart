import 'package:chef_pal/recipe_search/recipe_display.dart';
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
      builder: (_, recipes, __) => Expanded(
        child: SizedBox(
          child: ListView.builder(
            itemCount: recipes.recipes.length,
            itemBuilder: (BuildContext context, int index) {
              return RecipePreview(recipe: recipes.recipes[index]);
              // return Container(
              //   height: 50,
              //   //color: Colors.amber[colorCodes[index]],
              //   child: MaterialButton(
              //     //color: Colors.orange.shade50,
              //     onPressed: () {
              //       showDialog(
              //         context: context,
              //         builder: (context) {
              //           return Dialog(
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10)),
              //             elevation: 16,
              //             child: Container(
              //               height: MediaQuery.of(context).size.height / 1.2,
              //               width: MediaQuery.of(context).size.height / 1.1,
              //               child: RecipeView(recipes.recipes[index]),
              //             ),
              //           );
              //         },
              //       );
              //     },
              //     child: Text(
              //       '${recipes.recipes[index].title}',
              //       style: TextStyle(
              //         color: Colors.grey.shade900,
              //       ),
              //     ),
              //   ),
              // );
            },
          ),
        ),
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
      ],
    );
  }
}
