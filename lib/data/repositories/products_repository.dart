import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';
import '../../services/api_service.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final api = ref.watch(apiServiceProvider);
  return ProductsRepository(api);
});

class ProductsRepository {
  final ApiService _api;
  ProductsRepository(this._api);

  Future<List<Product>> getProducts() async {
    final res = await _api.get('/objects');
    if (res is List) {
      return res.map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }

  Future<Product> getProduct(String id) async {
    final res = await _api.get('/objects/$id');
    return Product.fromJson(res);
  }

  Future<Product> addProduct(Map<String, dynamic> data) async {
    final res = await _api.post('/objects', data);
    return Product.fromJson(res);
  }

  Future<void> updateProduct(String id, Map<String, dynamic> data) async {
    await _api.put('/objects/$id', data);
  }

  Future<void> deleteProduct(String id) async {
    await _api.delete('/objects/$id');
  }
}
