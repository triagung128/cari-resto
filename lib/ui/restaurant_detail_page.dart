import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import '../provider/restaurant_detail_provider.dart';
import '../data/enum/result_state.dart';
import '../widget/content_restaurant.dart';
import '../widget/text_message.dart';
import '../widget/loading_progress.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String restaurantId;

  const RestaurantDetailPage({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late RestaurantDetailProvider _provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(),
        restaurantId: widget.restaurantId,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<RestaurantDetailProvider>(
          builder: (_, provider, __) {
            _provider = provider;
            switch (provider.state) {
              case ResultState.loading:
                return const LoadingProgress();
              case ResultState.hasData:
                return ContentRestaurant(
                  provider: provider,
                  restaurant: provider.result.restaurant,
                );
              case ResultState.error:
                return TextMessage(
                  image: 'assets/images/no-internet.png',
                  message: 'Koneksi Terputus',
                  onPressed: () =>
                      _provider.fetchDetailRestaurant(widget.restaurantId),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
      floatingActionButton: _backButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _backButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
