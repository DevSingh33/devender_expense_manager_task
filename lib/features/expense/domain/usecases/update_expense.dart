import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense.dart';
import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
import 'package:devender_expense_manager_task/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

///1. creating parameters[expense] required for updating that expense
class UpdateExpenseParams extends Equatable {
  final Expense expense;

  const UpdateExpenseParams(this.expense);

  @override
  List<Object> get props => [expense];
}


///2. passing the parameters to the [ExpenseRepository]
class UpdateExpense implements UseCase<void, UpdateExpenseParams> {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateExpenseParams params) async {
    return await repository.updateExpense(params.expense);
  }
}
