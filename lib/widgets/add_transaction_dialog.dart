import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/providers/form_provider.dart';

class AddTransactionDialog extends ConsumerWidget {
  AddTransactionDialog({super.key, required this.onSubmit});

  final Function(String title, double amount, bool isIncome) onSubmit;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(transactionFormProvider);
    final formNotifier = ref.read(transactionFormProvider.notifier);

    return AlertDialog(
      title: const Text('Add Transaction'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              initialValue: form.title,
              onChanged: formNotifier.setTitle,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Title required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              initialValue: form.amount == 0
                  ? ''
                  : form.amount.toStringAsFixed(2),
              onChanged: (value) {
                final numValue = double.tryParse(value) ?? 0;
                formNotifier.setAmount(numValue);
              },
              validator: (value) {
                final numValue = double.tryParse(value ?? '');
                if (numValue == null || numValue <= 0) {
                  return 'Enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Type:'),
                const SizedBox(width: 8),
                DropdownButton<bool>(
                  value: form.isIncome,
                  items: const [
                    DropdownMenuItem(value: true, child: Text('Income')),
                    DropdownMenuItem(value: false, child: Text('Expense')),
                  ],
                  onChanged: (value) {
                    if (value != null) formNotifier.setIsIncome(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            formNotifier.reset();
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              onSubmit(form.title, form.amount, form.isIncome);
              formNotifier.reset();
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
