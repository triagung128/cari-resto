import 'package:flutter/material.dart';

import 'common/styles.dart';
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
    return MaterialApp(
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
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (_) => const RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            restaurantId: ModalRoute.of(context)?.settings.arguments as String),
        RestaurantSearchPage.routeName: (_) => const RestaurantSearchPage(),
      },
    );
  }
}
