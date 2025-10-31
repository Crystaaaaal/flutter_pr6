 class Transaction {
   final String name;
   final double amount;
   final String reason;
   final DateTime date;
   final bool isIncome;

   Transaction({
    required this.name,
     required this.amount,
     required this.reason,
     required this.date,
     required this.isIncome,
   });
 }
