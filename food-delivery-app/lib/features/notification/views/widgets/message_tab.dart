import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/notification/controllers/message_tab_controller.dart';
import 'package:food_delivery_app/features/notification/models/room.dart';
import 'package:food_delivery_app/features/notification/views/message_room.dart';
import 'package:food_delivery_app/features/notification/views/skeleton/message_tab_skeleton.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class MessageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageTabController>(
      init: MessageTabController(),
      builder: (controller) {
        Map<String, DirectRoom> rooms = controller.rooms;
        User? user = controller.user;
        return Obx(() =>
        (controller.isLoading.value)
            ? MessageTabSkeleton()
            : ListView(
          controller: controller.scrollController,
          children: [
            MainWrapper(child: CSearchBar()),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            for (var roomId in rooms.keys) ...[
              MainWrapper(
                child: ListTile(
                  onTap: () {
                    Get.to(() => MessageRoom(), arguments: {
                      'id': roomId
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(TSize.borderRadiusLg),
                    child: Image.asset(
                      TImage.hcBurger1,
                      height: TSize.imageMd,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    "${rooms[roomId]?.name}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rooms[roomId]?.latestMessage != null
                            ? "${rooms[roomId]?.latestMessage?.user == user?.id ? "You: " : ""}${rooms[roomId]?.latestMessage?.videos.isNotEmpty == true ? "sent a video" : rooms[roomId]?.latestMessage?.images.isNotEmpty == true ? "sent an image" : rooms[roomId]?.latestMessage?.content ?? ""}"
                            : "",
                        // ${rooms[roomId]?.name?.split(' ')[0]}
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${rooms[roomId]?.latestMessage?.createdAt != null ? THelperFunction.formatDate(rooms[roomId]?.latestMessage?.createdAt ?? DateTime.now()) : ""}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: TColor.textDesc),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SeparateSectionBar()
            ]
          ],
        ));
      },
    );
  }
}
