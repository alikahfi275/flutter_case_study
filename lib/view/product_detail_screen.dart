import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/providers/products_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Detail',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        foregroundColor: Colors.teal,
      ),
      body: productAsync.when(
        data: (product) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text('Year: ${product.data?['year'] ?? '-'}'),
              Text('Price: ${product.data?['price'] ?? '-'}'),
              Text('CPU: ${product.data?['CPU model'] ?? '-'}'),
              Text('Disk: ${product.data?['Hard disk size'] ?? '-'}'),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
