import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: heightScreen * 0.4,
                width: widthScreen,
                margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: NetworkImage(restaurant.pictureId!),
                    fit: BoxFit.cover,
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
                                restaurant.name!,
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
                                    '${restaurant.city}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: const Color(0xFF616161)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        RatingBarIndicator(
                          rating: restaurant.rating ?? 0,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Description :',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      restaurant.description!,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Foods :',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        children: restaurant.menus!.foods!.map((food) {
                          return _itemMenu(
                            'assets/images/food.png',
                            food.name,
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Drinks :',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        children: restaurant.menus!.drinks!.map((drink) {
                          return _itemMenu(
                            'assets/images/drink.png',
                            drink.name,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _itemMenu(String image, String? name) {
    return Container(
      height: 200,
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              height: 80,
              width: 60,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              '$name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
