import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:devender_expense_manager_task/core/logging/logging.dart';
import 'package:devender_expense_manager_task/features/expense/data/datasources/expense_local_datasource.dart';
import 'package:devender_expense_manager_task/features/expense/data/datasources/models/expense_model.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense_summary.dart';
import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
import 'package:uuid/uuid.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Expense>> addExpense(Expense expense) async {
    try {
      final expenseModel = ExpenseModel(
        id: const Uuid().v4(),
        amount: expense.amount,
        description: expense.description,
        date: expense.date,
        category: expense.category,
      );

      final result = await localDataSource.addExpense(expenseModel);
      // Convert ExpenseModel back to Expense before returning
      final addedExpense = Expense(
        id: result.id,
        amount: result.amount,
        description: result.description,
        date: result.date,
        category: result.category,
      );

      kLog(
        'Added Expense: '
        'id: ${addedExpense.id}, '
        'amount: ${addedExpense.amount}, '
        'description: ${addedExpense.description}, '
        'date: ${addedExpense.date}, '
        'category: ${addedExpense.category}',
        name: "expense added",
      );

      return Right(addedExpense);
    } catch (e) {
      kLog(e.toString(), name: "error in adding expense");
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      await localDataSource.deleteExpense(id);
      kLog('expense deleted with id- $id', name: "error in deleting expense");
      return const Right(null);
    } catch (e) {
      kLog(e.toString(), name: "error in deleting expense");
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> getExpenses() async {
    try {
      final expenseModel = await localDataSource.getExpenses();
      // Convert models to entities before returning
      final expenses = expenseModel
          .map((model) => Expense(
                id: model.id,
                amount: model.amount,
                description: model.description,
                date: model.date,
                category: model.category,
              ))
          .toList();

      kLog('no. of expenses found ${expenses.length}', name: "all expenses");

      return Right(expenses);
    } catch (e) {
      kLog(e.toString(), name: "error in getting expenses");
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Expense>> updateExpense(Expense expense) async {
    try {
      final expenseModel = ExpenseModel(
        id: expense.id,
        amount: expense.amount,
        description: expense.description,
        date: expense.date,
        category: expense.category,
      );

      final result = await localDataSource.updateExpense(expenseModel);
      // Convert ExpenseModel back to Expense before returning
      final updatedExpense = Expense(
        id: result.id,
        amount: result.amount,
        description: result.description,
        date: result.date,
        category: result.category,
      );

      kLog(
        'Updated Expense: '
        'id: ${updatedExpense.id}, '
        'amount: ${updatedExpense.amount}, '
        'description: ${updatedExpense.description}, '
        'date: ${updatedExpense.date}, '
        'category: ${updatedExpense.category}',
        name: "expense updated",
      );

      return Right(updatedExpense);
    } catch (e) {
      kLog(e.toString(), name: "error in updating expense");
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExpenseSummary>> getExpenseSummary(DateTime startDate, DateTime endDate) async {
    try {
      final expenseModels = await localDataSource.getExpenses();

      final expenses = expenseModels
          .map((model) => Expense(
                id: model.id,
                amount: model.amount,
                description: model.description,
                date: model.date,
                category: model.category,
              ))
          .toList();

      //1. filtering logic to only show within the passed [startDate], [endDate]
      final filteredExpenses = expenses.where((expense) {
        bool isWithinRange = (expense.date.isAtSameMomentAs(startDate) || expense.date.isAfter(startDate)) &&
            (expense.date.isAtSameMomentAs(endDate) || expense.date.isBefore(endDate.add(Duration(days: 1))));
        return isWithinRange;
      }).toList();

      //2. Calculate category-wise total
      final categoryWiseTotal = <String, double>{};
      double totalAmount = 0.0;

      for (var expense in filteredExpenses) {
        final category = expense.category.isNotEmpty ? expense.category : 'Uncategorized';

        categoryWiseTotal[category] = (categoryWiseTotal[category] ?? 0) + expense.amount;
        totalAmount += expense.amount;
      }

      //3. Calculate previous total (for previous period)
      final previousExpenses = expenses.where((expense) => expense.date.isBefore(startDate)).toList();

      double previousTotal = previousExpenses.fold(0, (sum, expense) => sum + expense.amount);

      kLog(
        'Expenses summary : '
        'totalAmount: $totalAmount, '
        'categoryWiseTotal: $categoryWiseTotal, '
        'startDate: $startDate, '
        'endDate: $endDate, '
        'previousTotal: $previousTotal',
        name: "expense summary",
      );

      return Right(
        ExpenseSummary(
          totalAmount: totalAmount,
          categoryWiseTotal: categoryWiseTotal,
          startDate: startDate,
          endDate: endDate,
          previousTotal: previousTotal,
        ),
      );
    } catch (e) {
      kLog(e.toString(), name: "error in getting expenses summary");
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
