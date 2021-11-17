import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/model/categories_model.dart';

final categoriesProvider =
    ChangeNotifierProvider<CategoriesProvider>((ref) => CategoriesProvider());

class CategoriesProvider extends ChangeNotifier {
  List<Category> category = [];

  Future<void> getCategories() async {
    try {
      var response =
          await Dio().get('https://student.valuxapps.com/api/categories');
      if (response.statusCode == 200) {
        print(response.data);
        response.data["data"]["data"].forEach((e) {
          category.add(Category.fromJson(e));
        });
      } else {
        print("Error");
        throw response.data;
      }
    } catch (e) {
      print("Error ==> $e");
    }
    notifyListeners();
  }
}
