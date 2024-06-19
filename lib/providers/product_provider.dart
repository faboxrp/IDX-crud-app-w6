import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/types/product.dart';

// Provider de Dio
final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
  validateStatus: (s) => true,
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
)));

// Provider para obtener la lista de productos
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.get("https://pucei.edu.ec:9101/api/v2/products");

  if (response.statusCode != 200) return [];

  final products = (response.data as List<dynamic>).map((item) {
    return Product.fromJson(item);
  }).toList();

  return products;
});

// Provider para obtener los detalles del producto por ID
final productDetailProvider = FutureProvider.family<Product, String>((ref, productId) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.get("https://pucei.edu.ec:9101/api/v2/products/$productId");

  if (response.statusCode != 200) return Product(id: "", name: "err", price: 0, stock: 0, urlImage: "", description: "err", v: 0);

  return Product.fromJson(response.data);
});
