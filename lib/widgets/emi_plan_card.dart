import 'package:flutter/material.dart';

import '../models/emi_plan.dart';
import '../theme/app_colors.dart';

class EmiPlanCard extends StatelessWidget {
  final EmiPlan plan;
  final bool selected;
  final VoidCallback onTap;

  const EmiPlanCard({
    super.key,
    required this.plan,
    required this.selected,
    required this.onTap,
  });

  String formatPrice(double value) {
    return "₹${value.toStringAsFixed(0)}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.purple.withOpacity(0.06)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? AppColors.purple
                : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? AppColors.purple
                  : Colors.grey,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "${plan.tenureMonths} Months",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "${formatPrice(plan.monthlyAmount)} / month",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  if (plan.isNoCost)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "No-cost EMI",
                        style: TextStyle(
                          color: AppColors.success,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
