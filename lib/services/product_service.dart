import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_project/models/product_model.dart';

class ProductService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['products'];
      return (data as List).map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
