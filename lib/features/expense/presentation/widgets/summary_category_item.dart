import 'package:devender_expense_manager_task/features/expense/domain/entities/expense_summary.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryItems extends StatelessWidget {
  final ExpenseSummary expenseSummary;

  const ExpenseCategoryItems({super.key, required this.expenseSummary});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: expenseSummary.categoryWiseTotal.entries.map((entry) {
        final color = _getCategoryColor(entry.key);
        return BlocItem(
          color: color,
          category: entry.key,
          amount: entry.value,
          percentage: (entry.value / expenseSummary.totalAmount) * 100,
        );
      }).toList(),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Colors.red.shade400;
      case 'transport':
        return Colors.blue.shade400;
      case 'shopping':
        return Colors.green.shade400;
      case 'entertainment':
        return Colors.purple.shade400;
      default:
        return Colors.grey.shade400;
    }
  }
}

class BlocItem extends StatelessWidget {
  final Color color;
  final String category;
  final double amount;
  final double percentage;

  const BlocItem({super.key, 
    required this.color,
    required this.category,
    required this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '₹${amount.toStringAsFixed(2)} (${percentage.toStringAsFixed(1)}%)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}