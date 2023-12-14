import 'package:flutter/material.dart';
import 'my_meal_details.dart';
import 'package:restaurant_application/color_schemes.g.dart';

class CategoryDetails extends StatelessWidget {
  final List<dynamic> categories;
  final List<dynamic> mealsInCategory;

  CategoryDetails({
    required this.categories,
    required this.mealsInCategory,
  });

  void onMealSelected(
      BuildContext context, Map<String, dynamic> selectedMeal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetails(selectedMeal: selectedMeal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Category Details - ${categories.firstWhere((cat) => cat['idCategory'] == mealsInCategory.first['idCategory'])['strCategory']}',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
               color: lightColorScheme.inversePrimary, // #F42068
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categories.firstWhere((cat) => cat['idCategory'] == mealsInCategory.first['idCategory'])['strCategory'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),// color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    categories.firstWhere((cat) => cat['idCategory'] == mealsInCategory.first['idCategory'])['strCategoryDescription'],
                    style: TextStyle(fontSize: 16),// color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: mealsInCategory.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () =>
                      onMealSelected(context, mealsInCategory[index]),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            mealsInCategory[index]['strMealThumb'],
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mealsInCategory[index]['strMeal'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.star, color: Colors.amber),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Implement your order now functionality
                                    },
                                    child: Text('Order Now'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
