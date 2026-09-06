import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../services/api_service.dart';

class MarketplaceProvider extends ChangeNotifier {
  final ApiService apiService;

  MarketplaceProvider({
    required this.apiService,
  });

  List<Product> products = [];

  bool isLoading = false;
  bool isLoadingMore = false;

  String? errorMessage;

  String selectedCategory = "All";
  String searchQuery = "";

  final List<String> categories = [
    "All",
    "Electronics",
    "Fashion",
    "Home",
  ];

  Future<void> loadProducts() async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      products = await apiService.getProducts(
        category: selectedCategory,
        search: searchQuery,
      );
    } catch (error) {
      errorMessage =
          "Unable to load marketplace products.";
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<void> selectCategory(
    String category,
  ) async {
    selectedCategory = category;

    await loadProducts();
  }

  Future<void> search(
    String value,
  ) async {
    searchQuery = value;

    await loadProducts();
  }

  Future<void> retry() async {
    await loadProducts();
  }
}
