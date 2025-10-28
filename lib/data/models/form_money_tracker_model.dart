class FormMoneyTrackerModel {
  final String title;
  final double amount;
  final bool isIncome;

  FormMoneyTrackerModel({
    this.title = '',
    this.amount = 0,
    this.isIncome = true,
  });

  FormMoneyTrackerModel copyWith({
    String? title,
    double? amount,
    bool? isIncome,
  }) {
    return FormMoneyTrackerModel(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      isIncome: isIncome ?? this.isIncome,
    );
  }
}
