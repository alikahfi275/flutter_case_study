import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/routes/bottom_nav.dart';
import '../view/product_detail_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottomNav(),
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/product-detail': (context) {
          final id = ModalRoute.of(context)!.settings.arguments as String;
          return ProductDetailScreen(id: id);
        },
      },
    );
  }
}
