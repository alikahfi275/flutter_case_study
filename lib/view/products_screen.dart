import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/animated.dart';
import '../../data/providers/products_provider.dart';
import '../../widgets/products_list.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsListProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      floatingActionButton: AnimatedSlideFade(
        type: AnimationType.slide,
        offset: const Offset(3, 2),
        child: FloatingActionButton(
          onPressed: () => () {},
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: productsAsync.when(
        data: (products) => RefreshIndicator(
          onRefresh: () =>
              ref.read(productsListProvider.notifier).refreshProducts(),
          child: ProductsList(products: products),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
