import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/products_repository.dart';

final productsListProvider =
    AsyncNotifierProvider<ProductsListNotifier, List<dynamic>>(
      ProductsListNotifier.new,
    );

class ProductsListNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    final repo = ref.watch(productsRepositoryProvider);
    return await repo.getProducts();
  }

  Future<void> refreshProducts() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.watch(productsRepositoryProvider);
      return await repo.getProducts();
    });
  }

  Future<void> addProduct(Map<String, dynamic> data) async {
    final repo = ref.watch(productsRepositoryProvider);
    await repo.addProduct(data);
    await refreshProducts();
  }

  Future<void> deleteProduct(String code) async {
    final repo = ref.watch(productsRepositoryProvider);
    await repo.deleteProduct(code);
    await refreshProducts();
  }
}
