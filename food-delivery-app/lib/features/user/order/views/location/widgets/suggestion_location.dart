import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/data/services/place_api_service.dart';
import 'package:food_delivery_app/features/user/order/models/custom_location.dart';
import 'package:food_delivery_app/features/user/order/views/location/skeleton/suggestion_location_list_skeleton.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';

class AddressSearch extends SearchDelegate<SuggestionLocation> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, SuggestionLocation('', ''));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<SuggestionLocation>>(
      future: PlaceApiService().fetchSuggestions(query),
      builder: (context, snapshot) {
        if (query.isEmpty) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Enter your address',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: SuggestionLocationListSkeleton());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No results found',
              style: Get.textTheme.headlineLarge,
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                MainWrapper(
                  child: ListTile(
                    leading: Icon(
                        Icons.location_on,
                        color: Colors.red
                    ),
                    title: Text(
                      "${snapshot.data![index].description}",
                      style: Get.theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    onTap: () {
                      close(context, snapshot.data![index]);
                    },
                  ),
                ),
                SeparateSectionBar()
              ],
            );
          },
        );
      },
    );
  }
}