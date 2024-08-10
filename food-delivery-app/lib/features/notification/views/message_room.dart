import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/features/notification/controllers/message_room_controller.dart';
import 'package:food_delivery_app/features/notification/controllers/message_tab_controller.dart';
import 'package:food_delivery_app/features/notification/models/message.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class MessageRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MessageRoomController(),
      builder: (controller) {
        return Scaffold(
          appBar: CAppBar(
            title: "${controller.room?.name ?? ""}",
          ),
          body: Column(
            children: [
              Expanded(
                child: Obx(
                      () => ListView.builder(
                    reverse: true,
                    controller: controller.scrollController,
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      DirectMessage message = controller.messages[index];
                      bool isCurrentUser = message.user == controller.currentUser?.id;
                      $print("${message.user} : ${controller.currentUser?.id}");
                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: isCurrentUser
                                      ? Colors.blue[100]
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "${message.content}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(height: 5),
                              ...message.images.map((image) => Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Image.asset(TImage.hcBurger1),
                              )),
                              ...message.videos.map((video) => Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Icon(Icons.videocam, size: 100),
                              )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Obx(
                    () => (controller.selectedImages.isNotEmpty || controller.selectedVideos.isNotEmpty)
                    ? Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.selectedImages.length + controller.selectedVideos.length,
                    itemBuilder: (context, index) {
                      if (index < controller.selectedImages.length) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Image.file(
                                File(controller.selectedImages[index].path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => controller.removeImage(index),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  child: Icon(Icons.close, size: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        int videoIndex = index - controller.selectedImages.length;
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(Icons.videocam, size: 100),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => controller.removeVideo(videoIndex),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  child: Icon(Icons.close, size: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                )
                    : Container(),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: controller.pickImages,
                  ),
                  IconButton(
                    icon: Icon(Icons.videocam),
                    onPressed: controller.pickVideos,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.textController,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: controller.sendMessage,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

