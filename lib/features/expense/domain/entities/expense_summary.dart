class ExpenseSummary {
  final double totalAmount;
  final Map<String, double> categoryWiseTotal;
  final DateTime startDate;
  final DateTime endDate;
  final double previousTotal; 

  const ExpenseSummary({
    required this.totalAmount,
    required this.categoryWiseTotal,
    required this.startDate,
    required this.endDate,
    required this.previousTotal,
  });
}

