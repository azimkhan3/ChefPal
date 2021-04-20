import 'package:chef_pal/ingredient_selection/ingredient_view.dart';
import 'package:chef_pal/profile/profile_view.dart';
import 'package:chef_pal/recipe_search/search_view.dart';
import 'package:chef_pal/utils/placeholder_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    IngredientsView(),
    SearchView(),
    PlaceholderWidget(Colors.green),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Saved',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}