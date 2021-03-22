import 'package:chef_pal/views/ui/ingredient_page/dropdown_widget.dart';
import 'package:flutter/material.dart';

class IngredientView extends StatefulWidget {
  IngredientView({Key key}) : super(key: key);

  @override
  _IngredientViewState createState() => _IngredientViewState();
}

class _IngredientViewState extends State<IngredientView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 48.0, left: 32.0, right: 32.0),
        child: Column(
          children: [
            Text("Ingredient Page"),
            CustomDropdown(text: "Dairy"),
            Spacer(),
            CustomDropdown(text: "Meats"),
            Spacer(),
            CustomDropdown(text: "Spices"),
            Spacer(),
            CustomDropdown(text: "Fruit"),
            Spacer(),
            CustomDropdown(text: "Vegetables"),
          ],
        ),
        //Text("My Ingredients"),
        //Column(),
      ),
    );
  }
}
