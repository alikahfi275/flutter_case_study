import 'package:flutter/material.dart';

class ExpenseTrackerScreen extends StatelessWidget {
  const ExpenseTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: const Center(child: Text('Expense Tracker Screen')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
