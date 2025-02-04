import 'package:devender_expense_manager_task/core/theme/app_theme.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/blocs/expense_bloc/expense_bloc.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/blocs/expense_summary_bloc/expense_summary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/init/hive_init.dart';
import 'core/init/notification_init.dart';
import 'features/expense/presentation/pages/home_page.dart';
import 'core/init/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initializing dependencies
  await HiveInit.init();
  await di.init();
  await NotificationService().initialize();
  
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ExpenseBloc>()),
        BlocProvider(create: (_) => di.sl<ExpenseSummaryBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: AppTheme.themeData,
        home: const HomePage(),
      ),
    );
  }
}
