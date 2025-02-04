import 'package:bloc/bloc.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/add_expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/delete_expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/get_expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/update_expense.dart';
import 'package:devender_expense_manager_task/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetExpenses getExpenses;
  final AddExpense addExpense;
  final UpdateExpense updateExpense;
  final DeleteExpense deleteExpense;

  ExpenseBloc({
    required this.getExpenses,
    required this.addExpense,
    required this.updateExpense,
    required this.deleteExpense,
  }) : super(ExpenseInitial()) {
    on<GetExpensesEvent>(_onGetExpenses);
    on<AddExpenseEvent>(_onAddExpense);
    on<UpdateExpenseEvent>(_onUpdateExpense);
    on<DeleteExpenseEvent>(_onDeleteExpense);
  }

  Future<void> _onGetExpenses(
    GetExpensesEvent event, 
    Emitter<ExpenseState> emit
  ) async {
    emit(ExpenseLoading());
    try {
      final result = await getExpenses(NoParams());
      result.fold(
        (failure) => emit(ExpenseError(failure.message)),
        (expenses) => emit(ExpenseLoaded(expenses)),
      );
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onAddExpense(
    AddExpenseEvent event, 
    Emitter<ExpenseState> emit
  ) async {
    emit(ExpenseLoading());
    try {
      final result = await addExpense(AddExpenseParams(event.expense));
      await result.fold(
        (failure) async => emit(ExpenseError(failure.message)),
        (_) async {
          final expensesResult = await getExpenses(NoParams());
          expensesResult.fold(
            (failure) => emit(ExpenseError(failure.message)),
            (expenses) => emit(ExpenseLoaded(expenses)),
          );
        },
      );
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onUpdateExpense(
    UpdateExpenseEvent event, 
    Emitter<ExpenseState> emit
  ) async {
    emit(ExpenseLoading());
    try {
      final result = await updateExpense(UpdateExpenseParams(event.expense));
      await result.fold(
        (failure) async => emit(ExpenseError(failure.message)),
        (_) async {
          final expensesResult = await getExpenses(NoParams());
          expensesResult.fold(
            (failure) => emit(ExpenseError(failure.message)),
            (expenses) => emit(ExpenseLoaded(expenses)),
          );
        },
      );
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onDeleteExpense(
    DeleteExpenseEvent event, 
    Emitter<ExpenseState> emit
  ) async {
    emit(ExpenseLoading());
    try {
      final result = await deleteExpense(DeleteExpenseParams(event.id));
      await result.fold(
        (failure) async => emit(ExpenseError(failure.message)),
        (_) async {
          final expensesResult = await getExpenses(NoParams());
          expensesResult.fold(
            (failure) => emit(ExpenseError(failure.message)),
            (expenses) => emit(ExpenseLoaded(expenses)),
          );
        },
      );
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }
}
