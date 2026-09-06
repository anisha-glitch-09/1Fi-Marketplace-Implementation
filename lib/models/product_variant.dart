class ProductVariant {
  final String id;
  final String name;
  final String value;
  final double price;

  ProductVariant({
    required this.id,
    required this.name,
    required this.value,
    required this.price,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['_id'],
      name: json['name'],
      value: json['value'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
