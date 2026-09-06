import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/marketplace_provider.dart';
import 'screens/shop_screen.dart';
import 'services/api_service.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(
    const OneFiApp(),
  );
}

class OneFiApp extends StatelessWidget {
  const OneFiApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MarketplaceProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "1Fi Marketplace",
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor:
              AppColors.background,

          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.purple,
          ),

          fontFamily: "Roboto",

          appBarTheme:
              const AppBarTheme(
            centerTitle: false,
            backgroundColor:
                AppColors.background,
            elevation: 0,
          ),
        ),
        home: const ShopScreen(),
      ),
    );
  }
}
