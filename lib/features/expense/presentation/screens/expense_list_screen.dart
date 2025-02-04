import 'package:devender_expense_manager_task/core/init/notification_init.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/blocs/expense_bloc/expense_bloc.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/screens/add_expense_screen.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/widgets/expense_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(GetExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          Tooltip(
            message: "Check a demo notification",
            child: GestureDetector(
              onTap: () async {
                await NotificationService().showDemoNotification();
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      Text("Test"),
                      Icon(Icons.settings_remote_rounded),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            if (state.expenses.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        "No expenses recorded yet!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Start adding your expenses to keep track of your spending.",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.separated(
              itemCount: state.expenses.length,
              itemBuilder: (context, index) {
                final expense = state.expenses[index];
                return ExpenseListItem(expense: expense);
              },
              separatorBuilder: (context, index) => Divider(
                // endIndent: 100,
                // indent: 100,
                color: Colors.amber.withOpacity(0.4),
              ),
            );
          } else if (state is ExpenseError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddExpenseScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
