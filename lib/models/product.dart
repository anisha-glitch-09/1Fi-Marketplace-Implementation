import 'emi_plan.dart';
import 'product_variant.dart';

class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String description;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final double rating;
  final List<ProductVariant> variants;
  final List<EmiPlan> emiPlans;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.variants,
    required this.emiPlans,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      brand: json['brand'],
      category: json['category'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      rating: (json['rating'] as num).toDouble(),
      variants: (json['variants'] as List)
          .map((e) => ProductVariant.fromJson(e))
          .toList(),
      emiPlans: (json['emiPlans'] as List)
          .map((e) => EmiPlan.fromJson(e))
          .toList(),
    );
  }
}
