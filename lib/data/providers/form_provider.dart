import 'package:flutter_riverpod/legacy.dart';

import '../models/form_money_tracker_model.dart';

class TransactionFormNotifier extends StateNotifier<FormMoneyTrackerModel> {
  TransactionFormNotifier() : super(FormMoneyTrackerModel());

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
    state = FormMoneyTrackerModel();
  }
}

final transactionFormProvider =
    StateNotifierProvider.autoDispose<
      TransactionFormNotifier,
      FormMoneyTrackerModel
    >((ref) => TransactionFormNotifier());
