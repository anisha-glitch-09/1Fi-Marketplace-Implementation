class EmiPlan {
  final String id;
  final int tenureMonths;
  final double monthlyAmount;
  final double totalAmount;
  final double interest;
  final bool isNoCost;

  EmiPlan({
    required this.id,
    required this.tenureMonths,
    required this.monthlyAmount,
    required this.totalAmount,
    required this.interest,
    required this.isNoCost,
  });

  factory EmiPlan.fromJson(Map<String, dynamic> json) {
    return EmiPlan(
      id: json['_id'],
      tenureMonths: json['tenureMonths'],
      monthlyAmount: (json['monthlyAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      interest: (json['interest'] as num).toDouble(),
      isNoCost: json['isNoCost'] ?? false,
    );
  }
}
