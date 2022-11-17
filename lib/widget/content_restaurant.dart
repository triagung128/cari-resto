import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/model/restaurant_detail_model.dart';
import 'card_menu.dart';

class ContentRestaurant extends StatelessWidget {
  final RestaurantDetail restaurant;

  const ContentRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: restaurant.pictureId,
            child: Container(
              height: heightScreen * 0.4,
              width: widthScreen,
              margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                size: 18,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                restaurant.city,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: const Color(0xFF616161)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${restaurant.rating}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(width: 4),
                        RatingBarIndicator(
                          rating: restaurant.rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 18,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Deskripsi :',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 4),
                Text(
                  restaurant.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(height: 24),
                Text(
                  'Menu Makanan :',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    children: restaurant.menus.foods.map((food) {
                      return CardMenu(
                        image: 'assets/images/food.png',
                        name: food.name,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Menu Minuman :',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    children: restaurant.menus.drinks.map((drink) {
                      return CardMenu(
                        image: 'assets/images/drink.png',
                        name: drink.name,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
