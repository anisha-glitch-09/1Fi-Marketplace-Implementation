import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/product_variant.dart';
import '../models/emi_plan.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../widgets/emi_plan_card.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {
  late ProductVariant selectedVariant;
  late EmiPlan selectedEmiPlan;

  bool isProceeding = false;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();

    selectedVariant =
        widget.product.variants.first;

    selectedEmiPlan =
        widget.product.emiPlans.first;
  }

  String formatPrice(double value) {
    return "₹${value.toStringAsFixed(0)}";
  }

  Future<void> proceed() async {
    setState(() {
      isProceeding = true;
    });

    try {
      final response =
          await apiService.proceedWithPlan(
        productId: widget.product.id,
        variantId: selectedVariant.id,
        emiPlanId: selectedEmiPlan.id,
      );

      if (!mounted) return;

      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 60,
                ),

                const SizedBox(height: 16),

                const Text(
                  "Plan selected",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  response["message"] ??
                      "Your EMI plan has been selected.",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.purple,
                      foregroundColor: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Done",
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isProceeding = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        title: const Text(
          "Product Details",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            18,
          ),
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed:
                  isProceeding ? null : proceed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16),
                ),
              ),
              child: isProceeding
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "Proceed with EMI",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(24),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand,
                    style: const TextStyle(
                      color:
                          AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color:
                          AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Text(
                        formatPrice(
                          selectedVariant.price,
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      if (product.originalPrice !=
                          null) ...[
                        const SizedBox(width: 10),
                        Text(
                          formatPrice(
                            product.originalPrice!,
                          ),
                          style:
                              const TextStyle(
                            decoration:
                                TextDecoration
                                    .lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Choose variant",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: product.variants
                        .map(
                          (variant) {
                            final selected =
                                selectedVariant
                                        .id ==
                                    variant.id;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedVariant =
                                      variant;
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color: selected
                                      ? AppColors
                                          .purple
                                          .withOpacity(
                                          0.08,
                                        )
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    12,
                                  ),
                                  border: Border.all(
                                    color: selected
                                        ? AppColors
                                            .purple
                                        : AppColors
                                            .border,
                                  ),
                                ),
                                child: Text(
                                  variant.value,
                                  style: TextStyle(
                                    color: selected
                                        ? AppColors
                                            .purple
                                        : AppColors
                                            .textPrimary,
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    "Select EMI plan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...product.emiPlans.map(
                    (plan) {
                      return EmiPlanCard(
                        plan: plan,
                        selected:
                            selectedEmiPlan.id ==
                                plan.id,
                        onTap: () {
                          setState(() {
                            selectedEmiPlan =
                                plan;
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Product details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color:
                          AppColors.textSecondary,
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
