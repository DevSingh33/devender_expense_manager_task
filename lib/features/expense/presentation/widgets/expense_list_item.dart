import 'package:devender_expense_manager_task/features/expense/domain/entities/expense.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/blocs/expense_bloc/expense_bloc.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseListItem extends StatelessWidget {
  final Expense expense;

  const ExpenseListItem({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(expense.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        context.read<ExpenseBloc>().add(DeleteExpenseEvent(expense.id));
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(_getCategoryIcon(expense.category)),
        ),
        title: Text(expense.description),
        subtitle: Text(DateFormat('MMM d, y').format(expense.date)),
        trailing: Text(
          '₹${expense.amount.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.amber),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddExpenseScreen(expense: expense),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'transport':
        return Icons.directions_car;
      case 'shopping':
        return Icons.shopping_bag;
      case 'entertainment':
        return Icons.movie;
      default:
        return Icons.currency_rupee_outlined;
    }
  }
}
