import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/personal/views/help_center/personal_help_detail.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';


class PersonalHelpCenterList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;
  final String filter;

  const PersonalHelpCenterList({
    Key? key,
    required this.reviews,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final filteredReviews = filter == 'All'
    //     ? reviews
    //     : reviews.where((review) {
    //   if (filter == 'Positive') {
    //     return review['type'] == 'positive';
    //   } else if (filter == 'Negative') {
    //     return review['type'] == 'negative';
    //   } else {
    //     return review['rating'].toString() == filter;
    //   }
    // }).toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            review["text"],
            style: Theme.of(context).textTheme.titleSmall,
          ),
          trailing: Icon(TIcon.arrowForward),
          onTap: () {
            Get.to(() => PersonalHelpDetailView(title: review["text"], content: review["text"]));
          },
        );
      },
    );
  }
}