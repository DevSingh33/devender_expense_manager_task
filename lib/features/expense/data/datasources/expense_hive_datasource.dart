import 'package:devender_expense_manager_task/features/expense/data/datasources/expense_local_datasource.dart';
import 'package:devender_expense_manager_task/features/expense/data/datasources/models/expense_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'expense_hive_datasource.g.dart';

@HiveType(typeId: 0)
class ExpenseHiveModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final double amount;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final DateTime date;
  
  @HiveField(4)
  final String category;

  ExpenseHiveModel({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
  });

  factory ExpenseHiveModel.fromExpenseModel(ExpenseModel model) {
    return ExpenseHiveModel(
      id: model.id,
      amount: model.amount,
      description: model.description,
      date: model.date,
      category: model.category,
    );
  }

  ExpenseModel toExpenseModel() {
    return ExpenseModel(
      id: id,
      amount: amount,
      description: description,
      date: date,
      category: category,
    );
  }
}

class ExpenseHiveDataSource implements ExpenseLocalDataSource {
  final Box<ExpenseHiveModel> expenseBox;
  final Uuid uuid;

  ExpenseHiveDataSource({
    required this.expenseBox,
    required this.uuid,
  });

  @override
  Future<ExpenseModel> addExpense(ExpenseModel expense) async {
    final hiveModel = ExpenseHiveModel.fromExpenseModel(expense);
    await expenseBox.put(hiveModel.id, hiveModel);
    return expense;
  }

  @override
  Future<void> deleteExpense(String id) async {
    await expenseBox.delete(id);
  }

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    return expenseBox.values
        .map((hiveModel) => hiveModel.toExpenseModel())
        .toList();
  }

  @override
  Future<ExpenseModel> updateExpense(ExpenseModel expense) async {
    final hiveModel = ExpenseHiveModel.fromExpenseModel(expense);
    await expenseBox.put(hiveModel.id, hiveModel);
    return expense;
  }
}
