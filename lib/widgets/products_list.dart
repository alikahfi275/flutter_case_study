import 'package:flutter/material.dart';

import '../../widgets/product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.products});

  final List<dynamic> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final data = product.data ?? {};
        return ProductCard(product: product, data: data);
      },
    );
  }
}
