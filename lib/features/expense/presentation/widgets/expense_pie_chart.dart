import 'dart:developer';

import 'package:devender_expense_manager_task/features/expense/domain/entities/expense_summary.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/blocs/expense_summary_bloc/expense_summary_bloc.dart';
import 'package:devender_expense_manager_task/features/expense/presentation/widgets/summary_category_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Enum to represent different date range presets
enum DateRangePreset { custom, thisWeek, thisMonth, last7Days, last30Days }

class ExpensePieChart extends StatelessWidget {
  final ExpenseSummary expenseSummary;

  const ExpensePieChart({
    super.key,
    required this.expenseSummary,
  });

  @override
  Widget build(BuildContext context) {
    // Check if there are any expenses
    final bool hasExpenses = expenseSummary.categoryWiseTotal.isNotEmpty && expenseSummary.totalAmount > 0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DateRangeSelector(expenseSummary: expenseSummary),

            const SizedBox(height: 16),

            if (hasExpenses)
              Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 300,
                      width: 300,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 20,
                          sections: _generatePieSections(),
                          sectionsSpace: 4,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Detailed Category wise expenses
                  ExpenseCategoryItems(expenseSummary: expenseSummary),
                ],
              )
            else
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    'No expenses found for selected date range',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Generate pie chart sections [category wise]
  List<PieChartSectionData> _generatePieSections() {
    return expenseSummary.categoryWiseTotal.entries.map((entry) {
      // Ensure safe percentage calculation
      final double percentage = expenseSummary.totalAmount > 0 ? (entry.value / expenseSummary.totalAmount) * 100 : 0;

      final color = _getCategoryColor(entry.key);

      return PieChartSectionData(
        color: color.withOpacity(0.7),
        value: percentage,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(1, 1),
            ),
          ],
        ),
      );
    }).toList();
  }

  /// Get different color for categories
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Colors.red.shade400;
      case 'transport':
        return Colors.blue.shade400;
      case 'shopping':
        return Colors.green.shade400;
      case 'entertainment':
        return Colors.purple.shade400;
      default:
        return Colors.grey.shade400;
    }
  }
}

class _DateRangeSelector extends StatefulWidget {
  final ExpenseSummary expenseSummary;

  const _DateRangeSelector({required this.expenseSummary});

  @override
  State<_DateRangeSelector> createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<_DateRangeSelector> {
  DateRangePreset _currentPreset = DateRangePreset.thisMonth;

  // Method to get preset date range
  DateTimeRange _getPresetDateRange(DateRangePreset preset) {
    final now = DateTime.now();
    switch (preset) {
      case DateRangePreset.thisWeek:
        // Get the start of the current week (assuming week starts on Monday)
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        return DateTimeRange(
          start: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
          end: now,
        );
      case DateRangePreset.thisMonth:
        return DateTimeRange(
          start: DateTime(now.year, now.month, 1),
          end: now,
        );
      case DateRangePreset.last7Days:
        return DateTimeRange(
          start: now.subtract(const Duration(days: 7)),
          end: now,
        );
      case DateRangePreset.last30Days:
        return DateTimeRange(
          start: now.subtract(const Duration(days: 30)),
          end: now,
        );
      case DateRangePreset.custom:
      default:
        return DateTimeRange(
          start: widget.expenseSummary.startDate,
          end: widget.expenseSummary.endDate,
        );
    }
  }

  void _selectDateRange() async {
    // Show bottom sheet with date range options
    final result = await showModalBottomSheet<DateRangePreset>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDateRangeOption('This Week', DateRangePreset.thisWeek),
              _buildDateRangeOption('This Month', DateRangePreset.thisMonth),
              _buildDateRangeOption('Last 7 Days', DateRangePreset.last7Days),
              _buildDateRangeOption('Last 30 Days', DateRangePreset.last30Days),
              _buildDateRangeOption('Custom Range', DateRangePreset.custom),
            ],
          ),
        );
      },
    );

    if (result != null) {
      if (result == DateRangePreset.custom) {
        _openCustomDateRangePicker();
      } else {
        _selectAndDispatchDateRange(result);
      }
    }
  }

  Widget _buildDateRangeOption(String title, DateRangePreset preset) {
    return ListTile(
      title: Text(title),
      trailing: _currentPreset == preset ? Icon(Icons.check, color: Colors.blue.shade700) : null,
      onTap: () => Navigator.pop(context, preset),
    );
  }

  void _openCustomDateRangePicker() async {
    final pickedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: widget.expenseSummary.startDate,
        end: widget.expenseSummary.endDate,
      ),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade700,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    // Check if the widget is still mounted before updating
    if (pickedDateRange != null && mounted) {
      _dispatchDateRangeEvent(pickedDateRange, DateRangePreset.custom);
    }
  }

  void _selectAndDispatchDateRange(DateRangePreset preset) {
    final dateRange = _getPresetDateRange(preset);
    _dispatchDateRangeEvent(dateRange, preset);
  }

  void _dispatchDateRangeEvent(DateTimeRange pickedDateRange, DateRangePreset preset) {
    log("summary event triggered for ${preset.name}");
    setState(() {
      _currentPreset = preset;
    });

    context.read<ExpenseSummaryBloc>().add(
          LoadExpenseSummaryEvent(
            startDate: pickedDateRange.start,
            endDate: pickedDateRange.end,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // Custom date formatter for day-month-year format
    final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Date Range Display
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Expense Summary',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _selectDateRange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getIconForPreset(_currentPreset),
                      size: 20,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      textAlign: TextAlign.center,
                      _getCurrentPresetLabel(dateFormatter),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.amber,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to get appropriate icon based on preset
  IconData _getIconForPreset(DateRangePreset preset) {
    switch (preset) {
      case DateRangePreset.thisWeek:
        return Icons.view_week_outlined;
      case DateRangePreset.thisMonth:
        return Icons.calendar_month_outlined;
      case DateRangePreset.last7Days:
        return Icons.calendar_today_outlined;
      case DateRangePreset.last30Days:
        return Icons.calendar_view_day_outlined;
      case DateRangePreset.custom:
      default:
        return Icons.edit_calendar_outlined;
    }
  }

  // Helper method to get label for current preset
  String _getCurrentPresetLabel(DateFormat dateFormatter) {
    final currentRange = _getPresetDateRange(_currentPreset);
    return '${dateFormatter.format(currentRange.start)} - ${dateFormatter.format(currentRange.end)}';
  }
}


