class TransactionFormState {
  final String title;
  final double amount;
  final bool isIncome;

  TransactionFormState({
    this.title = '',
    this.amount = 0,
    this.isIncome = true,
  });

  TransactionFormState copyWith({
    String? title,
    double? amount,
    bool? isIncome,
  }) {
    return TransactionFormState(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      isIncome: isIncome ?? this.isIncome,
    );
  }
}
