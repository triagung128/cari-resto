import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../common/styles.dart';
import '../data/model/restaurant_detail_model.dart';
import '../provider/restaurant_detail_provider.dart';
import 'bottom_sheet_review.dart';
import 'card_menu.dart';

class ContentRestaurant extends StatelessWidget {
  final RestaurantDetail restaurant;
  final RestaurantDetailProvider provider;

  const ContentRestaurant({
    super.key,
    required this.restaurant,
    required this.provider,
  });

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
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
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                              ),
                              builder: (context) {
                                return BottomSheetReview(
                                  provider: provider,
                                  restaurant: restaurant,
                                );
                              },
                            );
                          },
                          child: Text(
                            'Lihat Review',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: primaryColor,
                                    decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Kategori :',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 35,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: restaurant.categories.map((category) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Text(
                            category.name,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
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
                  height: 180,
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
                  height: 180,
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
