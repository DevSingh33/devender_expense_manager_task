import 'package:devender_expense_manager_task/features/expense/domain/entities/expense.dart';
import 'package:equatable/equatable.dart';

class ExpenseModel extends Expense with EquatableMixin {
  const ExpenseModel({
    required super.id,
    required super.amount,
    required super.description,
    required super.date,
    required super.category,
  });

  /// Factory method to create `ExpenseModel` from a JSON map.
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }

  /// Converts `ExpenseModel` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'category': category,
    };
  }

  @override
  List<Object?> get props => [id, amount, description, date, category];

  @override
  bool get stringify => true;
}