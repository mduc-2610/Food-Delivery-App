import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class MessageRoomSkeleton extends StatelessWidget {
  const MessageRoomSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: BoxSkeleton(
          height: 30,
          width: 150,
        ),
        actions: [
          BoxSkeleton(
            height: 40,
            width: 40,
            borderRadius: TSize.borderRadiusCircle,
          ),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal,)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) {
                bool isCurrentUser = index % 2 == 0;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment:
                    isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isCurrentUser) ...[
                        BoxSkeleton(
                          height: TSize.avatarMd,
                          width: TSize.avatarMd,
                          borderRadius: TSize.borderRadiusCircle,
                        ),
                        SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      ],
                      Column(
                        crossAxisAlignment:
                        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          BoxSkeleton(
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.6,
                            borderRadius: 15,
                          ),
                          SizedBox(height: 8),
                          BoxSkeleton(
                            height: 12,
                            width: 60,
                          ),
                        ],
                      ),
                      if (isCurrentUser) ...[
                        SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                        BoxSkeleton(
                          height: TSize.avatarMd,
                          width: TSize.avatarMd,
                          borderRadius: TSize.borderRadiusCircle,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          // _buildMediaPreviewSkeleton(),
          _buildInputRowSkeleton(),
        ],
      ),
    );
  }

  Widget _buildMediaPreviewSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          BoxSkeleton(
            height: 40,
            width: 40,
            borderRadius: TSize.borderRadiusCircle,
          ),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
          Expanded(
            child: BoxSkeleton(
              height: 40,
              width: double.infinity,
              borderRadius: TSize.borderRadiusLg,
            ),
          ),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
          BoxSkeleton(
            height: 40,
            width: 40,
            borderRadius: TSize.borderRadiusCircle,
          ),
        ],
      ),
    );
  }

  Widget _buildInputRowSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          BoxSkeleton(
            height: 40,
            width: 40,
            borderRadius: TSize.borderRadiusCircle,
          ),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
          Expanded(
            child: BoxSkeleton(
              height: 40,
              width: double.infinity,
              borderRadius: TSize.borderRadiusLg,
            ),
          ),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
          BoxSkeleton(
            height: 40,
            width: 40,
            borderRadius: TSize.borderRadiusCircle,
          ),
        ],
      ),
    );
  }
}
