import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/providers/product_form_provider.dart';
import '../data/providers/products_provider.dart';

class ProductDialog extends ConsumerWidget {
  const ProductDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(productFormProvider);
    final formNotifier = ref.read(productFormProvider.notifier);

    return AlertDialog(
      title: const Text('Add Product'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              initialValue: form.name,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: formNotifier.updateName,
            ),
            TextFormField(
              initialValue: form.year,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Year'),
              onChanged: formNotifier.updateYear,
            ),
            TextFormField(
              initialValue: form.price,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
              onChanged: formNotifier.updatePrice,
            ),
            TextFormField(
              initialValue: form.cpu,
              decoration: const InputDecoration(labelText: 'CPU Model'),
              onChanged: formNotifier.updateCpu,
            ),
            TextFormField(
              initialValue: form.disk,
              decoration: const InputDecoration(labelText: 'Hard Disk Size'),
              onChanged: formNotifier.updateDisk,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            formNotifier.reset();
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: form.isValid
              ? () async {
                  final product = formNotifier.toProduct();

                  try {
                    await ref
                        .read(productsListProvider.notifier)
                        .addProduct(product.toJson());

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product added successfully!'),
                          backgroundColor: Colors.teal,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to add product'),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  } finally {
                    formNotifier.reset();
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
