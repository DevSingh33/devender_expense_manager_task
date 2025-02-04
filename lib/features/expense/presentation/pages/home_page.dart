import 'package:devender_expense_manager_task/features/expense/presentation/screens/expense_list_screen.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/screens/expense_summary_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; //to help with bottom navigation bar items switching 
  
  final List<Widget> _pages = const [
    ExpenseListScreen(),
    ExpenseSummaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee_sharp),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}