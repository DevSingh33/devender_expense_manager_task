import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/update_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock setup
class MockExpenseRepository extends Mock implements ExpenseRepository {}

const String kErrorUpdatingExpanses = "error in updating expenses";
void main() {
  late UpdateExpense useCase;
  late MockExpenseRepository mockRepository;

  setUp(() {
    mockRepository = MockExpenseRepository();
    useCase = UpdateExpense(mockRepository);
  });

  final tExpense=
    Expense(
      id: '1',
      amount: 100.0,
      description: 'Test updated description',
      date: DateTime(2026, 2, 3),
      category: 'Food',
    );
 

  test('should return the expenses from repository when updated', () async {
    // arrange
    when(() => mockRepository.updateExpense(tExpense)).thenAnswer((_) async => Right(tExpense));

    // act
    final result = await useCase(UpdateExpenseParams(tExpense));

    // assert
    expect(result, Right(tExpense));
    verify(() => mockRepository.updateExpense(tExpense)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return [Failure] when updating expense result in error', () async {
    //arrange
    when(() => mockRepository.updateExpense(tExpense)).thenAnswer((_) async => const Left(Failure(kErrorUpdatingExpanses)));

    //act
    final result = await useCase(UpdateExpenseParams(tExpense));

    //assert
    verify(() => mockRepository.updateExpense(tExpense));
    verifyNoMoreInteractions(mockRepository);
    expect(result, equals(const Left(Failure(kErrorUpdatingExpanses))));
  });
}
