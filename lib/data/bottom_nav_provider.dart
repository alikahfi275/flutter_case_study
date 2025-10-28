import 'package:case_study/view/expense_tracker_screen.dart';
import 'package:case_study/view/products_screen.dart';
import 'package:flutter_riverpod/legacy.dart';

class BottomNavNotifier extends StateNotifier<int> {
  BottomNavNotifier() : super(0);

  final pages = const [ExpenseTrackerScreen(), ProductsScreen()];

  void changePage(int index) {
    state = index;
  }
}

final bottomNavProvider = StateNotifierProvider<BottomNavNotifier, int>((ref) {
  return BottomNavNotifier();
});
