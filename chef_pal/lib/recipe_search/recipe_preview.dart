import 'package:chef_pal/ingredient_selection/firestore.dart';
import 'package:chef_pal/recipe_search/recipe_display.dart';
import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipePreview extends StatelessWidget {
  final Recipe recipe;
  const RecipePreview({Key key, @required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // if (recipe.imgLink.length > 0) Image.network(recipe.imgLink),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 16,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 1.2,
                          width: MediaQuery.of(context).size.height / 1.1,
                          child: RecipeView(recipe),
                        ),
                      );
                    },
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        recipe.title,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 55,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<FirestoreService>().favoriteRecipe(recipe);
                },
                child: Icon(
                  Icons.favorite_outline,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
