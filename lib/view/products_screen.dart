import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: const Center(child: Text('Products Screen')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
