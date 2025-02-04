import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/get_expense.dart';
import 'package:devender_expense_manager_task/usecases/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock setup
class MockExpenseRepository extends Mock implements ExpenseRepository {
}
const String kErrorGetExpanses = "error in getting expenses";void main() {
  late GetExpenses useCase;
  late MockExpenseRepository mockRepository;

  setUp(() {
    mockRepository = MockExpenseRepository();
    useCase = GetExpenses(mockRepository);
  });

  final tExpenses = [
    Expense(
      id: '1',
      amount: 100.0,
      description: 'Test expense',
      date: DateTime(2025, 2, 3),
      category: 'Food',
    ),
  ];

  test('should get list of expenses from repository', () async {
    // arrange
    when(()=> mockRepository.getExpenses())
        .thenAnswer((_) async => Right(tExpenses));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Right(tExpenses));
    verify(()=>mockRepository.getExpenses()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });


    test('should return [Failure] when getting expenses result in an error', () async {
    //arrange
    when(() => mockRepository.getExpenses()).thenAnswer((_) async => const Left(Failure(kErrorGetExpanses)));
    
    //act
    final result = await useCase(NoParams());
    //assert

    verify(() => mockRepository.getExpenses());
    verifyNoMoreInteractions(mockRepository);
    expect(result, equals(const Left(Failure(kErrorGetExpanses))));
  });
}
