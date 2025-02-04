part of 'expense_bloc.dart';

sealed class ExpenseState extends Equatable {
  const ExpenseState();
  
  @override
  List<Object> get props => [];
}


class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  const ExpenseLoaded(this.expenses);
}

class ExpenseError extends ExpenseState {
  final String message;
  const ExpenseError(this.message);
}
