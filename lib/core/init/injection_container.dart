import 'package:devender_expense_manager_task/features/expense/data/datasources/expense_local_datasource.dart';
import 'package:devender_expense_manager_task/features/expense/data/datasources/expense_hive_datasource.dart';
import 'package:devender_expense_manager_task/features/expense/data/repositories/expense_repository_impl.dart';
import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/add_expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/delete_expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/get_expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/get_expense_summary.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/update_expense.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/blocs/expense_bloc/expense_bloc.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/blocs/expense_summary_bloc/expense_summary_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

final sl = GetIt.instance;

///initialize get it dependency injection
Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ExpenseBloc(
    getExpenses: sl(),
    addExpense: sl(),
    updateExpense: sl(),
    deleteExpense: sl(),
  ));
  
  sl.registerFactory(() => ExpenseSummaryBloc(
    getExpenseSummary: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => GetExpenses(sl()));
  sl.registerLazySingleton(() => AddExpense(sl()));
  sl.registerLazySingleton(() => UpdateExpense(sl()));
  sl.registerLazySingleton(() => DeleteExpense(sl()));
  sl.registerLazySingleton(() => GetExpenseSummary(sl()));

  // Repository
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseHiveDataSource(
      expenseBox: sl(),
      uuid: sl(),
    ),
  );

  // External
  final expenseBox = await Hive.openBox<ExpenseHiveModel>('expenses');
  sl.registerLazySingleton(() => expenseBox);
  sl.registerLazySingleton(() => const Uuid());
}