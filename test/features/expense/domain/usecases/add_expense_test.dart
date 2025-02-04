import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/add_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock setup
class MockExpenseRepository extends Mock implements ExpenseRepository {}

const String kErrorAddExpanses = "error in adding expenses";
void main() {
  late AddExpense useCase;
  late MockExpenseRepository mockRepository;

  setUp(() {
    mockRepository = MockExpenseRepository();
    useCase = AddExpense(mockRepository);
  });

  final tExpense=
    Expense(
      id: '1',
      amount: 100.0,
      description: 'Test expense',
      date: DateTime(2025, 2, 3),
      category: 'Food',
    );
 

  test('should return the expenses from repository', () async {
    // arrange
    when(() => mockRepository.addExpense(tExpense)).thenAnswer((_) async => Right(tExpense));

    // act
    final result = await useCase(AddExpenseParams(tExpense));

    // assert
    expect(result, Right(tExpense));
    verify(() => mockRepository.addExpense(tExpense)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return [Failure] when adding expense result in error', () async {
    //arrange
    when(() => mockRepository.addExpense(tExpense)).thenAnswer((_) async => const Left(Failure(kErrorAddExpanses)));

    //act
    final result = await useCase(AddExpenseParams(tExpense));

    //assert
    verify(() => mockRepository.addExpense(tExpense));
    verifyNoMoreInteractions(mockRepository);
    expect(result, equals(const Left(Failure(kErrorAddExpanses))));
  });
}
