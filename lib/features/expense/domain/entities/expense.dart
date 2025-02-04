class Expense {
  final String id;
  final double amount;
  final String description;
  final DateTime date;
  final String category;

  const Expense({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
  });
}
