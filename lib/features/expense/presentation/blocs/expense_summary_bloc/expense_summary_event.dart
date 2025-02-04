part of 'expense_summary_bloc.dart';

sealed class ExpenseSummaryEvent extends Equatable {
  const ExpenseSummaryEvent();

  @override
  List<Object> get props => [];
}

class LoadExpenseSummaryEvent extends ExpenseSummaryEvent {
  final DateTime startDate;
  final DateTime endDate;

  const LoadExpenseSummaryEvent({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}