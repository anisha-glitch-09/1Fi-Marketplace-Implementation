import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'marketplace_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({
    super.key,
  });

  @override
  State<ShopScreen> createState() =>
      _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int selectedTab = 0;

  final List<String> tabs = [
    "Top Brands",
    "Nearby Stores",
    "1Fi Marketplace",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            // HERO
            Container(
              height: 360,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF3811A9),
                    Color(0xFF5D18D5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 28,
                    top: 45,
                    right: 180,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white70,
                            ),
                          ),
                          child: const Text(
                            "✦ NO-COST EMIs",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        const Text(
                          "Shop today,\nPay later using\nMutual funds.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 31,
                            height: 1.08,
                            fontWeight:
                                FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 14),

                        const Text(
                          "No credit score required. No interest.\nBacked by your investments.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    right: 15,
                    bottom: 30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                            .withOpacity(0.08),
                      ),
                      child: const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                        size: 90,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // TAB BAR
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding:
                    const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1EDFF),
                  borderRadius:
                      BorderRadius.circular(40),
                ),
                child: Row(
                  children: List.generate(
                    tabs.length,
                    (index) {
                      final selected =
                          selectedTab == index;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration:
                                const Duration(
                              milliseconds: 200,
                            ),
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              vertical: 15,
                              horizontal: 5,
                            ),
                            decoration:
                                BoxDecoration(
                              color: selected
                                  ? Colors.white
                                  : Colors
                                      .transparent,
                              borderRadius:
                                  BorderRadius
                                      .circular(35),
                              boxShadow: selected
                                  ? [
                                      BoxShadow(
                                        color: Colors
                                            .black
                                            .withOpacity(
                                          0.08,
                                        ),
                                        blurRadius: 8,
                                      )
                                    ]
                                  : [],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  tabs[index],
                                  textAlign:
                                      TextAlign.center,
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow
                                          .ellipsis,
                                  style: TextStyle(
                                    color: selected
                                        ? AppColors
                                            .purple
                                        : AppColors
                                            .textSecondary,
                                    fontSize: 13,
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),

                                if (selected) ...[
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    height: 4,
                                    width: 35,
                                    decoration:
                                        BoxDecoration(
                                      color: AppColors
                                          .purple,
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        10,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: const [
                  _TopBrandsPage(),
                  _NearbyStoresPage(),
                  MarketplaceScreen(),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
          const _ShopBottomNavigation(),
    );
  }
}

class _TopBrandsPage extends StatelessWidget {
  const _TopBrandsPage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Top Brands",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _NearbyStoresPage extends StatelessWidget {
  const _NearbyStoresPage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Nearby Stores",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _ShopBottomNavigation
    extends StatelessWidget {
  const _ShopBottomNavigation();

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: 1,
      backgroundColor: Colors.white,
      indicatorColor:
          AppColors.purple.withOpacity(0.1),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon:
              Icon(Icons.home),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.storefront_outlined),
          selectedIcon:
              Icon(Icons.storefront),
          label: "Shop",
        ),
        NavigationDestination(
          icon: Icon(Icons.currency_rupee),
          label: "EMI Dues",
        ),
        NavigationDestination(
          icon: Icon(Icons.show_chart),
          label: "Limit",
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
    );
  }
}
