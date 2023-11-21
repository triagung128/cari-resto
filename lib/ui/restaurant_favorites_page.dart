import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../data/enum/result_state.dart';
import '../provider/database_provider.dart';
import '../widget/card_restaurant.dart';
import '../widget/text_message.dart';

class RestaurantFavoritesPage extends StatelessWidget {
  static const routeName = '/restaurant_favorites';

  const RestaurantFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildList(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Favorit'),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (_, provider, __) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            itemCount: provider.favorites.length,
            itemBuilder: (_, index) {
              final restaurant = provider.favorites[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else {
          return TextMessage(
            image: 'assets/images/empty-data.png',
            message: provider.message,
          );
        }
      },
    );
  }
}
