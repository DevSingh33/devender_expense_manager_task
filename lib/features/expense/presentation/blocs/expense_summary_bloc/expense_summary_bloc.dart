import 'package:bloc/bloc.dart';
import 'package:devender_expense_manager_task/features/expense/domain/entities/expense_summary.dart';
import 'package:devender_expense_manager_task/features/expense/domain/usecases/get_expense_summary.dart';
import 'package:equatable/equatable.dart';

part 'expense_summary_event.dart';
part 'expense_summary_state.dart';

// Bloc
class ExpenseSummaryBloc extends Bloc<ExpenseSummaryEvent, ExpenseSummaryState> {
  final GetExpenseSummary getExpenseSummary;

  ExpenseSummaryBloc({
    required this.getExpenseSummary,
  }) : super(ExpenseSummaryInitial()) {
    on<LoadExpenseSummaryEvent>((event, emit) async {
      emit(ExpenseSummaryLoading());

      // Wrap startDate and endDate in ExpenseSummaryParams
      final params = ExpenseSummaryParams(
        event.startDate,
        event.endDate,
      );

      final result = await getExpenseSummary(params); // Pass params instead of separate arguments

      result.fold(
        (failure) => emit(ExpenseSummaryError(failure.message)),
        (summaryData) {
          // Now, summaryData is an ExpenseSummary entity directly
          emit(ExpenseSummaryLoaded(summaryData)); // Emit the ExpenseSummary directly as state
        },
      );
    });
  }
}