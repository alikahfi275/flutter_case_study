import 'package:flutter_riverpod/legacy.dart';

import '../../view/money_tracker_screen.dart';
import '../../view/products_screen.dart';

class BottomNavNotifier extends StateNotifier<int> {
  BottomNavNotifier() : super(0);

  final pages = const [MoneyTrackerScreen(), ProductsScreen()];

  void changePage(int index) {
    state = index;
  }
}

final bottomNavProvider = StateNotifierProvider<BottomNavNotifier, int>((ref) {
  return BottomNavNotifier();
});
