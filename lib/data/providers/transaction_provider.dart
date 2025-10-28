import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/transaction.dart';

final uuid = const Uuid();

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super([]);

  void addTransaction(String title, double amount, bool isIncome) {
    final newTransaction = Transaction(
      id: uuid.v4(),
      title: title,
      amount: amount,
      isIncome: isIncome,
    );
    state = [newTransaction, ...state];
  }

  void deleteTransaction(String id) {
    state = state.where((tx) => tx.id != id).toList();
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) {
      return TransactionNotifier();
    });
