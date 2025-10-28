import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/animated.dart';
import '../core/utils/formatters.dart';
import '../widgets/money_tracker_card.dart';
import '../widgets/money_trackers_list.dart';
import '../widgets/money_tracker_dialog.dart';
import '../data/providers/moeny_tracker_provider.dart';

class MoneyTrackerScreen extends ConsumerWidget {
  const MoneyTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(moneyTrackerProvider);
    final transactionsNotifier = ref.read(moneyTrackerProvider.notifier);

    final totalIncome = transactions
        .where((t) => t.isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);
    final totalExpense = transactions
        .where((t) => !t.isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);

    void openAddDialog() {
      showDialog(
        context: context,
        builder: (_) => MoneyTrackerDialog(
          onSubmit: (title, amount, isIncome) {
            transactionsNotifier.addTransaction(title, amount, isIncome);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Money Tracker',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: AnimatedSlideFade(
        type: AnimationType.slide,
        offset: const Offset(0, 2),
        child: FloatingActionButton(
          onPressed: openAddDialog,
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Card(
            margin: const EdgeInsets.all(16),
            color: Colors.teal.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Income',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatRupiah(totalIncome),
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Expense',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatRupiah(totalExpense),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: transactions.isEmpty
                ? const Center(child: Text('No Data'))
                : MoneyTrackerList(
                    items: transactions,
                    itemBuilder: (context, tx, index) => MoneyTrackerCard(
                      transaction: tx,
                      onDelete: () =>
                          transactionsNotifier.deleteTransaction(tx.id),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
