import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/rating_bar.dart';
import 'package:food_delivery_app/common/widgets/sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class FoodDetailReviewView extends StatefulWidget {
  @override
  _FoodDetailReviewViewState createState() => _FoodDetailReviewViewState();
}

class _FoodDetailReviewViewState extends State<FoodDetailReviewView> {
    final List<Map<String, dynamic>> reviews = [
    {
      'name': 'John Doe',
      'date': '29/03/2024',
      'review':
      'Delicious chicken burger! Loved the crispy chicken and the bun was perfectly toasted. Definitely a new favorite!',
      'rating': 5,
      'type': 'positive'
    },
    {
      'name': 'David',
      'date': '10/04/2024',
      'review':
      'Absolutely delicious! The chicken burger was juicy and flavorful, with just the right amount of seasoning. Highly recommend!',
      'rating': 5,
      'type': 'positive'
    },
    {
      'name': 'Tom',
      'date': '05/04/2024',
      'review':
      'One of the best chicken burgers I’ve ever had! The chicken was tender and the bun was soft. Loved every bite!',
      'rating': 5,
      'type': 'positive'
    },
    {
      'name': 'James',
      'date': '29/03/2024',
      'review':
      'The chicken burger was okay, but it was a bit overcooked for my liking. The toppings were fresh, though.',
      'rating': 3,
      'type': 'negative'
    },
      {
        'name': 'David',
        'date': '10/04/2024',
        'review':
        'Absolutely delicious! The chicken burger was juicy and flavorful, with just the right amount of seasoning. Highly recommend!',
        'rating': 5,
        'type': 'positive'
      },
      {
        'name': 'Tom',
        'date': '05/04/2024',
        'review':
        'One of the best chicken burgers I’ve ever had! The chicken was tender and the bun was soft. Loved every bite!',
        'rating': 5,
        'type': 'positive'
      },
      {
        'name': 'James',
        'date': '29/03/2024',
        'review':
        'The chicken burger was okay, but it was a bit overcooked for my liking. The toppings were fresh, though.',
        'rating': 3,
        'type': 'negative'
      },];

  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                CSliverAppBar(
                  title: "Reviews",
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '4.9',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                                RatingBarIndicator(
                                  rating: 4.9,
                                  itemBuilder: (context, index) => SvgPicture.asset(
                                    TIcon.fillStar
                                  ),
                                  itemCount: 5,
                                  itemSize: TSize.iconLg,
                                ),
                                SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                                Text(
                                  '(1,205)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: TSize.spaceBetweenItemsVertical),
                            SizedBox(
                              width: TDeviceUtil.getScreenWidth() * 0.5,
                              child: RatingDistribution()
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      FilterBar(
                        selectedFilter: selectedFilter,
                        onFilterChanged: (filter) {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      ReviewList(
                        reviews: reviews,
                        filter: selectedFilter,
                      ),
                    ],
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

class RatingDistribution extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 5; i >= 1; i--)...[
          CRatingBar(prefixText: i.toString() ,value: i / 5),
        ]

      ],
    );
  }
}

class FilterBar extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const FilterBar({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Positive', 'Negative', '5', '4', '3', '2', '1'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: filters.map((filter) {
          final bool isSelected = selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(
                filter,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  onFilterChanged(filter);
                }
              },
              selectedColor: TColor.primary,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;
  final String filter;

  const ReviewList({
    Key? key,
    required this.reviews,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredReviews = filter == 'All'
        ? reviews
        : reviews.where((review) {
      if (filter == 'Positive') {
        return review['type'] == 'positive';
      } else if (filter == 'Negative') {
        return review['type'] == 'negative';
      } else {
        return review['rating'].toString() == filter;
      }
    }).toList();

    return MainWrapper(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: filteredReviews.length,
        itemBuilder: (context, index) {
          final review = filteredReviews[index];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150'),
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(review['name']),
                          Text(review['date']),
                        ],
                      )
                    ],
                  ),

                  RatingBarIndicator(
                    rating: review['rating'].toDouble(),
                    itemBuilder: (context, index) => SvgPicture.asset(
                      TIcon.fillStar,
                    ),
                    itemCount: 5,
                    itemSize: TSize.iconSm,
                  ),
                ],
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review['review']),
                ],
              ),
              SizedBox(height: TSize.spaceBetweenSections),

            ],
          );
        },
      ),
    );
  }
}