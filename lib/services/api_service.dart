import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  // This is important
  // Android emulator -> host machine
  static const String baseUrl = "http://10.0.2.2:5000/api";
  Future<List<Product>> getProducts({
    String? category,
    String? search,
  }) async {
    final query = <String, String>{};
    if (category != null && category != "All") {
      query["category"] = category;
    }
    if (search != null && search.trim().isNotEmpty) {
      query["search"] = search.trim();
    }
    final uri = Uri.parse(
      "$baseUrl/products",
    ).replace(
      queryParameters: query,
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception("Failed to load products");
    }
    final decoded = jsonDecode(response.body);
    final List data = decoded["data"];
    return data
        .map(
          (item) => Product.fromJson(item),
        )
        .toList();
  }
  Future<Product> getProduct(String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/products/$id"),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load product");
    }

    final decoded = jsonDecode(response.body);

    return Product.fromJson(decoded["data"]);
  }

  Future<Map<String, dynamic>> proceedWithPlan({
    required String productId,
    String? variantId,
    required String emiPlanId,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/orders"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "productId": productId,
        "variantId": variantId,
        "emiPlanId": emiPlanId,
      }),
    );
    final decoded = jsonDecode(response.body);
    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        decoded["message"] ?? "Unable to proceed",
      );
    }
    return decoded;
  }
}
