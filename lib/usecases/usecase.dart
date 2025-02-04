import 'package:dartz/dartz.dart';
import 'package:devender_expense_manager_task/core/error/failures.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
// NoParams class for use cases that don't need parameters
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}