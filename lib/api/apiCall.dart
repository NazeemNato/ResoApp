import 'dart:convert';
import 'package:http/http.dart';

class CategoryDishes {
  final String dishId;
  final String dishName;
  final double dishPrice;
  final String dishImage;
  final String dishCurrency;
  final double dishCalories;
  final String dishDescription;
  final bool dishAvailability;
  final double dishType;
  final String nextUrl;

  CategoryDishes(
      {this.dishId,
      this.dishName,
      this.dishPrice,
      this.dishImage,
      this.dishCurrency,
      this.dishCalories,
      this.dishDescription,
      this.dishAvailability,
      this.dishType,
      this.nextUrl});

  factory CategoryDishes.fromJson(Map<String, dynamic> json) {
    return CategoryDishes(
        dishId: json['dish_id'],
        dishName: json['dish_name'],
        dishPrice: json['dish_price'].toDouble(),
        dishImage:json['dish_image'] ,
        dishCurrency: json['dish_currency'],
        dishCalories: json['dish_calories'].toDouble(),
        dishDescription: json['dish_description'],
        dishAvailability: json['dish_Availability'],
        dishType: json['dish_Type'].toDouble(),
        nextUrl: json['nexturl']);
  }
}

class DishMenu {
  final String menuCategory;
  final String menuCategoryId;
  final String menuCategoryImage;
  final String nextUrl;
  final List<CategoryDishes> categoryDishes;

  DishMenu({
    this.menuCategory,
    this.menuCategoryId,
    this.menuCategoryImage,
    this.nextUrl,
    this.categoryDishes,
  });

  factory DishMenu.fromJson(Map<String, dynamic> json) {
    return DishMenu(
      menuCategory: json['menu_category'],
      menuCategoryId: json['menu_category_id'],
      menuCategoryImage: json['menu_category_image'],
      nextUrl: json['nexturl'],
      categoryDishes: List<CategoryDishes>.from(
          json['category_dishes'].map((x) => CategoryDishes.fromJson(x))),
    );
  }
// ************************************************ API **************************************************************
  static Foodsoc<List<DishMenu>> get all {
    return Foodsoc(
        url: "http://www.mocky.io/v2/5dfccffc310000efc8d2c1ad",
        parser: (response) {
          final result = json.decode(response.body.toString());
          Iterable list = result[0]['table_menu_list'];
    
          return list.map((model) => DishMenu.fromJson(model)).toList();
        });
  }
}

class Foodsoc<Opp> {
  final String url;
  final Opp Function(Response response) parser;
  Foodsoc({this.url, this.parser});
}

class MyFoodService {
  Future<Opp> load<Opp>(Foodsoc<Opp> Foodsoc) async {
    final response = await get(Foodsoc.url);
    if (response.statusCode == 200)
      return Foodsoc.parser(response);
    else
      throw Exception('F');
  }
}