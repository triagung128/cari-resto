import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/styles.dart';
import 'data/api/api_service.dart';
import 'data/db/database_helper.dart';
import 'data/model/restaurant_list_model.dart';
import 'provider/database_provider.dart';
import 'provider/restaurant_list_provider.dart';
import 'provider/restaurant_search_provider.dart';
import 'ui/home_page.dart';
import 'ui/restaurant_detail_page.dart';
import 'ui/restaurant_list_page.dart';
import 'ui/restaurant_search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
              ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: secondaryColor,
            titleTextStyle: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (_) => const HomePage(),
          RestaurantListPage.routeName: (_) => const RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
          RestaurantSearchPage.routeName: (_) => const RestaurantSearchPage(),
        },
      ),
    );
  }
}
