import 'package:flutter/material.dart';

class RecipeSearch extends StatefulWidget {
  @override
  _RecipeSearchState createState() => _RecipeSearchState();
}

class _RecipeSearchState extends State<RecipeSearch> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchField = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade700),
        controller: _searchField,
        decoration: InputDecoration(
          labelText: "Search all Recipes",
          labelStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
