import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../models/product.dart';

final productProvider = FutureProvider<List<Product>>((ref) async {
  final response = await Dio().get('https://dummyjson.com/products');
  final List products = response.data['products'];
  return products.map((e) => Product.fromJson(e)).toList();
});
