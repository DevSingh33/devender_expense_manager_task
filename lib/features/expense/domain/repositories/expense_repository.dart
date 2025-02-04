import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense_summary.dart';

abstract class ExpenseRepository {

  ///get all the expenses will return [List<Expense>] if success, if fail will return [Failure]
  Future<Either<Failure, List<Expense>>> getExpenses();

  ///add [expense] will return [Expense] if success, if fail will return [Failure]
  Future<Either<Failure, Expense>> addExpense(Expense expense);

  ///update the passed [expense] will return [Expense] if success, if fail will return [Failure]
  Future<Either<Failure, Expense>> updateExpense(Expense expense);

  ///delete the [expense] with [id] will return [void] if success, if fail will return [Failure]
  Future<Either<Failure, void>> deleteExpense(String id);

  ///get summary of all the expenses during period [startDate]- [endDate] will return [ExpenseSummary] if success, if fail will return [Failure]
  Future<Either<Failure, ExpenseSummary>> getExpenseSummary(
  DateTime startDate, DateTime endDate);
}