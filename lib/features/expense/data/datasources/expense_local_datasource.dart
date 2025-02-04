import 'package:devender_expense_manager_task/features/expense/data/datasources/models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  ///get all the expenses from the local db
  Future<List<ExpenseModel>> getExpenses();

  ///add [expense] to local db
  Future<ExpenseModel> addExpense(ExpenseModel expense);

  ///update the [expense] in  the local db
  Future<ExpenseModel> updateExpense(ExpenseModel expense);

  ///delete the expense from local db with [id]
  Future<void> deleteExpense(String id);
}