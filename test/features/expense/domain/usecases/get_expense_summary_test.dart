import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense_summary.dart';
import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/get_expense_summary.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

const String kErrorGettingExpansesSummary = "error in getting expenses summary";

void main() {
  late GetExpenseSummary useCase;
  late MockExpenseRepository mockExpenseRepository;

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    useCase = GetExpenseSummary(mockExpenseRepository);
  });

  final tStartDate = DateTime(2025, 2, 1);
  final tEndDate = DateTime(2025, 2, 28);

  ExpenseSummary tExpenseSummary = ExpenseSummary(
    startDate:DateTime(2024, 2, 3),
    endDate: DateTime(2025, 2, 3),
    totalAmount: 150.0,
    previousTotal: 100.0,
    categoryWiseTotal: {'Food':10} ,
  );

  test(
    'should return expense summary from the repository when successful',
    () async {
      // Arrange
      when(() => mockExpenseRepository.getExpenseSummary(tStartDate, tEndDate))
          .thenAnswer((_) async =>  Right(tExpenseSummary));

      // Act
      final result = await useCase(ExpenseSummaryParams(tStartDate, tEndDate));

      // Assert
      expect(result,  Right(tExpenseSummary));
      verify(() => mockExpenseRepository.getExpenseSummary(tStartDate, tEndDate))
          .called(1);
    },
  );

 test('should return [Failure] when getting  expenses summary result in error', () async {
    //arrange
    when(() => mockExpenseRepository.getExpenseSummary(tStartDate,tEndDate)).thenAnswer((_) async => const Left(Failure(kErrorGettingExpansesSummary)));

    //act
    final result = await useCase(ExpenseSummaryParams(tStartDate,tEndDate));

    //assert
    verify(() => mockExpenseRepository.getExpenseSummary(tStartDate,tEndDate));
    verifyNoMoreInteractions(mockExpenseRepository);
    expect(result, equals(const Left(Failure(kErrorGettingExpansesSummary))));
  });
}