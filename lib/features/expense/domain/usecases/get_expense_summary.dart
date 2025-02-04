import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense_summary.dart';
import 'package:devender_expense_manager_task/features/expense/domain/repositories/expense_repository.dart';
import 'package:devender_expense_manager_task/usecases/usecase.dart';
import 'package:equatable/equatable.dart';


///1. creating parameters[startDate], [endDate] required for getting the expenses summary
class ExpenseSummaryParams extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const ExpenseSummaryParams(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

///2. passing the parameters to the [ExpenseRepository]
class GetExpenseSummary implements UseCase<void, ExpenseSummaryParams> {
  final ExpenseRepository repository;

  GetExpenseSummary(this.repository);

  @override
  Future<Either<Failure, ExpenseSummary>> call(ExpenseSummaryParams params) async {
    return await repository.getExpenseSummary(params.startDate, params.endDate);
  }
}
