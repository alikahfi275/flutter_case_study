import 'package:case_study/data/bottom_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNav extends ConsumerWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);
    final navController = ref.read(bottomNavProvider.notifier);

    return Scaffold(
      body: navController.pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => navController.changePage(index),
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey.shade400,

        selectedIconTheme: const IconThemeData(size: 24, color: Colors.teal),
        unselectedIconTheme: IconThemeData(
          size: 22,
          color: Colors.grey.shade400,
        ),

        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w300,
        ),

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.memory), label: 'Riverpod'),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_sync),
            label: 'Rest API',
          ),
        ],
      ),
    );
  }
}
