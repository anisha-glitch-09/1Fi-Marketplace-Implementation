import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/marketplace_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({
    super.key,
  });

  @override
  State<MarketplaceScreen> createState() =>
      _MarketplaceScreenState();
}

class _MarketplaceScreenState
    extends State<MarketplaceScreen> {
  final TextEditingController searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context
            .read<MarketplaceProvider>()
            .loadProducts();
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketplaceProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return Scaffold(
          backgroundColor: AppColors.background,

          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: provider.loadProducts,

              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        20,
                        20,
                        0,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "1Fi Marketplace",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            "Shop now. Pay later using your investments.",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(18),
                              border: Border.all(
                                color: AppColors.border,
                              ),
                            ),
                            child: TextField(
                              controller:
                                  searchController,
                              onSubmitted: provider.search,
                              decoration:
                                  const InputDecoration(
                                hintText:
                                    "Search products...",
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                                border:
                                    InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            height: 44,
                            child: ListView.separated(
                              scrollDirection:
                                  Axis.horizontal,
                              itemCount:
                                  provider.categories.length,
                              separatorBuilder:
                                  (_, __) =>
                                      const SizedBox(
                                width: 8,
                              ),
                              itemBuilder:
                                  (context, index) {
                                final category =
                                    provider.categories[
                                        index];

                                return CategoryChip(
                                  label: category,
                                  selected:
                                      provider
                                              .selectedCategory ==
                                          category,
                                  onTap: () {
                                    provider
                                        .selectCategory(
                                      category,
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 26),

                          const Text(
                            "Featured products",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          const SizedBox(height: 14),
                        ],
                      ),
                    ),
                  ),

                  if (provider.isLoading)
                    const SliverFillRemaining(
                      child: Center(
                        child:
                            CircularProgressIndicator(),
                      ),
                    )
                  else if (provider.errorMessage != null)
                    SliverFillRemaining(
                      child: _ErrorState(
                        message:
                            provider.errorMessage!,
                        onRetry: provider.retry,
                      ),
                    )
                  else if (provider.products.isEmpty)
                    const SliverFillRemaining(
                      child: _EmptyState(),
                    )
                  else
                    SliverPadding(
                      padding:
                          const EdgeInsets.fromLTRB(
                        20,
                        0,
                        20,
                        30,
                      ),
                      sliver: SliverGrid(
                        delegate:
                            SliverChildBuilderDelegate(
                          (context, index) {
                            final product =
                                provider.products[
                                    index];

                            return ProductCard(
                              product: product,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetailScreen(
                                      product: product,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          childCount:
                              provider.products.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.67,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 50,
              color: Colors.grey,
            ),
            const SizedBox(height: 15),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 60,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "No products available",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Try another category.",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
