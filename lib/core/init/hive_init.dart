import 'package:devender_expense_manager_task/features/expense/data/datasources/expense_hive_datasource.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInit {

  static String modelName = 'expenses_hive_model';

  ///initialize hive for the app
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseHiveModelAdapter());
    await Hive.openBox<ExpenseHiveModel>(modelName);
  }
}
