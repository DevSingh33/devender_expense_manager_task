import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
import 'package:devender_expense_manager_task/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

///1. creating parameters[id] required for removing that expense
class DeleteExpenseParams extends Equatable {
  final String id;

  const DeleteExpenseParams(this.id);

  @override
  List<Object> get props => [id];
}

///2. passing the parameters to the [ExpenseRepository]
class DeleteExpense implements UseCase<void, DeleteExpenseParams> {
  final ExpenseRepository repository;

  DeleteExpense(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteExpenseParams params) async {
    return await repository.deleteExpense(params.id);
  }
}
