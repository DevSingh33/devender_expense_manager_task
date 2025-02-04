//todo
// import 'package:devender_expense_manager_task/features/expense/data/datasources/expense_local_datasource.dart';
// import 'package:devender_expense_manager_task/features/expense/data/models/expense_model.dart';
// import 'package:devender_expense_manager_task/features/expense/domain/entities/expense.dart';
// import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockNotesLocalDataSource extends Mock implements ExpenseLocalDataSource {}

// class MockExpenseRepository extends Mock implements ExpenseRepository {}

// void main() {
//   late MockExpenseRepository expenseRepository;
//   late MockNotesLocalDataSource localDataSource;

//   setUp(() {
//     localDataSource = MockNotesLocalDataSource();
//     expenseRepository = MockExpenseRepository();
//   });

//   ExpenseModel tExpenseModel = ExpenseModel(
//     id: '1',
//     amount: 100.0,
//     description: 'Test expense',
//     date: DateTime(2025, 2, 3),
//     category: 'Food',
//   );
//   Expense tExpense = Expense(
//     id: '1',
//     amount: 100.0,
//     description: 'Test expense',
//     date: DateTime(2025, 2, 3),
//     category: 'Food',
//   );
//   final tExpensesList = [
//     ExpenseModel(
//       id: '1',
//       amount: 1310.0,
//       description: 'Test expense1',
//       date: DateTime(2025, 2, 3),
//       category: 'Food',
//     ),
//     ExpenseModel(
//       id: '2',
//       amount: 100.0,
//       description: 'Test expense2',
//       date: DateTime(2025, 2, 3),
//       category: 'Food',
//     ),
//     ExpenseModel(
//       id: '3',
//       amount: 7.0,
//       description: 'Test expense3',
//       date: DateTime(2025, 2, 3),
//       category: 'Food',
//     ),
//   ];

//   group('expense repo - getAllExpense()', () {
//     test('should call getAllExpense() when call expense repository', () async {
//       //arrange
//       when(() => localDataSource.getExpenses()).thenAnswer((_) async => tExpensesList);
//       //act
//       await expenseRepository.getExpenses();
//       //assert
//       verify(() => localDataSource.getExpenses());
//       verifyNoMoreInteractions(localDataSource);
//     });

//   });

// }
