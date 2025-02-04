part of 'expense_bloc.dart';

sealed class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}
class GetExpensesEvent extends ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  final Expense expense;
  const AddExpenseEvent(this.expense);
}

class UpdateExpenseEvent extends ExpenseEvent {
  final Expense expense;
  const UpdateExpenseEvent(this.expense);
}

class DeleteExpenseEvent extends ExpenseEvent {
  final String id;
  const DeleteExpenseEvent(this.id);
}