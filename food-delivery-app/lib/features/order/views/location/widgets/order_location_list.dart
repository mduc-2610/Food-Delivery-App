import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/cards/container_card.dart';
import 'package:food_delivery_app/common/widgets/misc/radio_tick.dart';
import 'package:food_delivery_app/features/order/models/location.dart';
import 'package:food_delivery_app/features/order/views/location/order_location_add.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class LocationList extends StatefulWidget {
  final List<MyLocation> locations;

  const LocationList({Key? key, required this.locations}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.locations.length + 1,
      itemBuilder: (context, index) {
        if (index < widget.locations.length) {
          final location = widget.locations[index];
          return _buildLocationItem(location.name, location.address, index, _selectedIndex, (value) {
            setState(() {
              // if(_selectedIndex == value) {
              //   _selectedIndex = -1;
              // }
              // else {
              //   _selectedIndex = value!;
              // }
                _selectedIndex = value!;
            });
          });
        } else {
          return Container(
            margin: EdgeInsets.only(bottom: TSize.spaceBetweenItemsVertical),
            child: ContainerCard(
              bgColor: TColor.iconBgCancel,
              borderColor: Colors.transparent,
              child: ListTile(
                onTap: () {
                  Get.to(() => OrderLocationAddView());
                },
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  TIcon.add,
                  color: TColor.primary,
                ),
                title: Text(
                  "Add New Location",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.primary),
                ),
              ),
            ),
          );
        }
      },
    );
  }
  Widget _buildLocationItem(String text1, String text2, int value, int groupValue, Function(int?) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: TSize.spaceBetweenItemsVertical),
      child: InkWell(
        onTap: () {
          onChanged(value);
        },
        child: ContainerCard(
          borderColor: value == groupValue ? TColor.disable : TColor.borderPrimary,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              text1,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: value == groupValue
                    ? Theme.of(context).textTheme.titleLarge?.color
                    : TColor.disable,
              ),
            ),
            subtitle: Text(
              text2,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: value == groupValue
                    ? Theme.of(context).textTheme.titleSmall?.color
                    : TColor.disable,
              ),
            ),
            trailing: RadioTick(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ),
        )
      ),
    );
  }
}

