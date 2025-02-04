import 'package:devender_expense_manager_task/features/expense/presentation/blocs/expense_summary_bloc/expense_summary_bloc.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/widgets/expense_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseSummaryScreen extends StatefulWidget {
  const ExpenseSummaryScreen({super.key});

  @override
  State<ExpenseSummaryScreen> createState() => _ExpenseSummaryScreenState();
}

class _ExpenseSummaryScreenState extends State<ExpenseSummaryScreen> {
  @override
  void initState() {
    super.initState();

    //default show  1 year expense summary
    context
        .read<ExpenseSummaryBloc>()
        .add(LoadExpenseSummaryEvent(endDate: DateTime.now(), startDate: DateTime.now().subtract(Duration(days: 365))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Summary'),
      ),
      body: BlocBuilder<ExpenseSummaryBloc, ExpenseSummaryState>(
        builder: (context, state) {
          if (state is ExpenseSummaryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseSummaryLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ExpensePieChart(expenseSummary: state.summary),
                  const SizedBox(height: 24),
                ],
              ),
            );
          } else if (state is ExpenseSummaryError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
