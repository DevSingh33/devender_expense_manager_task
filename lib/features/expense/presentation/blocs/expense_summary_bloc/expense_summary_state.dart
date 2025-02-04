part of 'expense_summary_bloc.dart';

sealed class ExpenseSummaryState extends Equatable {
  const ExpenseSummaryState();
  
  @override
  List<Object> get props => [];
}

class ExpenseSummaryInitial extends ExpenseSummaryState {}

class ExpenseSummaryLoading extends ExpenseSummaryState {}

class ExpenseSummaryLoaded extends ExpenseSummaryState {
  final ExpenseSummary summary;

  const ExpenseSummaryLoaded(this.summary);

  @override
  List<Object> get props => [summary];
}

class ExpenseSummaryError extends ExpenseSummaryState {
  final String message;

  const ExpenseSummaryError(this.message);

  @override
  List<Object> get props => [message];
}
