import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import '../provider/restaurant_list_provider.dart';
import '../data/enum/result_state.dart';
import '../widget/card_restaurant.dart';
import '../widget/text_message.dart';
import '../widget/loading_progress.dart';
import 'restaurant_search_page.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  late RestaurantListProvider _provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildList(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Restaurant App'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, RestaurantSearchPage.routeName);
          },
        ),
      ],
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantListProvider>(
      builder: (_, provider, __) {
        _provider = provider;

        switch (provider.state) {
          case ResultState.loading:
            return const LoadingProgress();
          case ResultState.hasData:
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: provider.result.count,
              itemBuilder: (_, index) {
                final restaurant = provider.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              },
            );
          case ResultState.noData:
            return const TextMessage(
              image: 'assets/images/no-data.png',
              message: 'Data Kosong',
            );
          case ResultState.error:
            return TextMessage(
              image: 'assets/images/no-internet.png',
              message: 'Koneksi Terputus',
              onPressed: () => _provider.fetchAllRestaurant(),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
