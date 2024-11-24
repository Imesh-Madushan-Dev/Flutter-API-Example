import 'dart:convert';

import 'package:flutter_api_example/models/poduct_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //* Fetch data from API
  Future<List<Product>> fetchAllProducts() async {
    const String url = 'https://fakestoreapi.com/products';

    try {
      final response = await http.get(Uri.parse(url));

      // 200 means success
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<Product> products =
            responseData.map((json) => Product.fromJson(json)).toList();
        return products;
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

  //* Fetch data from API

  Future<Product> fetchProductById(int id) async {
    String url = 'https://fakestoreapi.com/products/$id';

    try {
      final response = await http.get(Uri.parse(url));

      // 200 means success
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        Product product = Product.fromJson(responseData);
        return product;
      } else {
        throw Exception('Failed to load data! ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }
}
