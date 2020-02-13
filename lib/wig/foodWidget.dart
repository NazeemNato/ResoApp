import 'package:flutter/material.dart';
import 'package:fdap/api/apiCall.dart';

class FoodListPage extends StatelessWidget {
  final String category;
  final List<CategoryDishes> foodList;

  const FoodListPage(
      {Key key, @required this.foodList, @required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color(0xFF545D68),
            onPressed: () {}),
        title: Text(
          category,
          style: TextStyle(
              fontFamily: 'Varela', fontSize: 20.0, color: Color(0xFF545D68)),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Color(0xFF545D68),
              onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          return _buildFoodCard(foodList[index]);
        },
      ),
    );
  }

  Widget _buildFoodCard(CategoryDishes dish) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    dish.dishName,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        dish.dishCurrency +
                            " " +
                            dish.dishPrice.toString() +
                            '\n' +
                            dish.dishCalories.toString() +
                            " Calories",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    dish.dishDescription,
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.black38, fontSize: 12),
                  ),
                  const SizedBox(height: 8.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: SizedBox(
                      height: 30.0,
                      width: 80.0,
                      child: Material(
                        color: Colors.green,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "0",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                dish.dishImage,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
