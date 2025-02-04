import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/delete_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock setup
class MockExpenseRepository extends Mock implements ExpenseRepository {}

const String kErrorDeleteExpanses = "error in deleting expenses";
void main() {
  late DeleteExpense useCase;
  late MockExpenseRepository mockRepository;

  setUp(() {
    mockRepository = MockExpenseRepository();
    useCase = DeleteExpense(mockRepository);
  });

  final String tId= "1";
 

  test('should return void when an expense deleted successfully ', () async {
    // arrange
    when(() => mockRepository.deleteExpense(tId)).thenAnswer((_) async => Right(null));

    // act
    final result = await useCase(DeleteExpenseParams(tId));

    // assert
    expect(result, Right(null));
    verify(() => mockRepository.deleteExpense(tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return [Failure] when deleting expense result in error', () async {
    //arrange
    when(() => mockRepository.deleteExpense(tId)).thenAnswer((_) async => const Left(Failure(kErrorDeleteExpanses)));

    //act
    final result = await useCase(DeleteExpenseParams(tId));

    //assert
    verify(() => mockRepository.deleteExpense(tId));
    verifyNoMoreInteractions(mockRepository);
    expect(result, equals(const Left(Failure(kErrorDeleteExpanses))));
  });
}
