import 'package:chef_pal/views/ui/search_page/recipe_search_widget.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
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
            children: [
              RecipeSearch(),
            ],
          ),
        ),
      ),
    );
  }
}
