import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'my_category_details.dart';

import 'package:restaurant_application/color_schemes.g.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> categories = [];
  List<dynamic> meals = [];
  final TextEditingController _categoryController = TextEditingController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final categoryResponse =
        await http.get(Uri.parse('http://localhost:3000/categories'));
    final mealResponse = await http.get(Uri.parse('http://localhost:3000/meals'));

    setState(() {
      categories = jsonDecode(categoryResponse.body);
      meals = jsonDecode(mealResponse.body);
    });
  }

  Future<String?> addNewCategory(String categoryName) async {
    final response = await createCategory(categoryName);

    if (response != null) {
      setState(() {
        categories.add(response);
      });
      return response['strCategory'];
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> createCategory(String categoryName) async {
    final newCategory = {
      'strCategory': categoryName,
      'strCategoryDescription':
          'New Category Description', // Replace with actual category description logic
    };

    final response = await http.post(
      Uri.parse('http://localhost:3000/categories'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newCategory),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to add new category: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  }

  void onCategorySelected(String categoryId) {
    List<dynamic> mealsInCategory =
        meals.where((meal) => meal['idCategory'] == categoryId).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetails(
          categories: categories,
          mealsInCategory: mealsInCategory,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
            },
          ),
         

         
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(width: 8),
                Text(
                  'Search...',
                  style: TextStyle(color: Color(0xFFF42068)),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: lightColorScheme.surfaceTint,),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Wrap(
                        spacing: 16.0,
                        runSpacing: 16.0,
                        children: categories.map((category) {
                          return GestureDetector(
                            onTap: () =>
                                onCategorySelected(category['idCategory']),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.restaurant,
                                        size: 40,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      category['strCategory'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextField(
                    controller: _categoryController,
                    decoration: InputDecoration(hintText: 'Enter Category'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      addNewCategory(_categoryController.text);
                    },
                    child: Text('Add Category'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}