import 'package:devender_expense_manager_task/features/expense/domain/entities/expense_summary.dart';
import 'package:equatable/equatable.dart';

class ExpenseSummaryModel extends ExpenseSummary with EquatableMixin {
  const ExpenseSummaryModel({
    required super.totalAmount,
    required super.categoryWiseTotal,
    required super.startDate,
    required super.endDate,
    required super.previousTotal,
  });

  /// Factory method to create an `ExpenseSummary` from a JSON response.
  factory ExpenseSummaryModel.fromJson(Map<String, dynamic> json) {
    return ExpenseSummaryModel(
      totalAmount: (json['totalAmount'] as num).toDouble(),
      categoryWiseTotal: Map<String, double>.from(json['categoryWiseTotal']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      previousTotal: (json['previousTotal'] as num).toDouble(),
    );
  }

  /// Converts `ExpenseSummary` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'totalAmount': totalAmount,
      'categoryWiseTotal': categoryWiseTotal,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'previousTotal': previousTotal,
    };
  }

  @override
  List<Object?> get props => [totalAmount, categoryWiseTotal, startDate, endDate, previousTotal];

  @override
  bool get stringify => true;
}
