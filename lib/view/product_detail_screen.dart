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
        data: (product) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.data != null)
                  for (final entry in (product.data ?? {}).entries)
                    Text('${entry.key}: ${entry.value}')
                else
                  const Text('No data'),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
