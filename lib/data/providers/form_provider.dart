import 'package:flutter_riverpod/legacy.dart';

import '../../data/models/form.dart';

class TransactionFormNotifier extends StateNotifier<TransactionFormState> {
  TransactionFormNotifier() : super(TransactionFormState());

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void setAmount(double value) {
    state = state.copyWith(amount: value);
  }

  void setIsIncome(bool value) {
    state = state.copyWith(isIncome: value);
  }

  void reset() {
    state = TransactionFormState();
  }
}

final transactionFormProvider =
    StateNotifierProvider.autoDispose<
      TransactionFormNotifier,
      TransactionFormState
    >((ref) => TransactionFormNotifier());
