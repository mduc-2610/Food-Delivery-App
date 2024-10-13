import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/features/notification/controllers/message_room_controller.dart';
import 'package:food_delivery_app/features/notification/models/message.dart';
import 'package:food_delivery_app/features/notification/views/skeleton/message_room_skeleton.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MessageRoomView extends StatelessWidget {
  final ViewType viewType;

  const MessageRoomView({this.viewType = ViewType.user});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageRoomController>(
      init: MessageRoomController(viewType: viewType),
      builder: (controller) {
        return Obx(() =>
          (controller.isLoading.value)
            ? MessageRoomSkeleton()
            : Scaffold(
          appBar: CAppBar(
            title: "${controller.room?.name ?? ""}",
            actions: [
              CircleAvatar(
                child: THelperFunction.getValidImage(
                  controller.room?.avatar,
                  width: TSize.avatarMd,
                  height: TSize.avatarMd,
                  radius: TSize.borderRadiusCircle,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                  reverse: true,
                  controller: controller.scrollController,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    DirectMessage message = controller.messages[index];
                    bool isCurrentUser = message.user?.id == controller.currentUser?.id;
                    return GestureDetector(
                      onLongPress: (isCurrentUser)
                          ? () => controller.showDeleteModal(context, controller, message)
                          : null,
                      child: Align(
                        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if(!isCurrentUser)...[
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(TSize.borderRadiusCircle),
                                  child: THelperFunction.getValidImage(
                                    controller.room?.avatar,
                                    width: TSize.avatarMd,
                                    height: TSize.avatarMd,
                                  ),
                                ),
                                SizedBox(width: TSize.spaceBetweenItemsHorizontal,),
                              ],
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  children: [
                                    if(message.content != null && message.content != "")...[
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: isCurrentUser ? Colors.blue[100] : Colors.grey[300],
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          "${message.content}",
                                          style: Get.textTheme.bodySmall?.copyWith(
                                              color: THelperFunction.isDarkMode(context)
                                                  ? TColor.light
                                                  : TColor.dark
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                    ],
                                    if (message.images.isNotEmpty || message.videos.isNotEmpty)
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: isCurrentUser ? Colors.blue[100]?.withOpacity(0.5) : Colors.grey[300],
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: GridView.count(
                                          reverse: true,
                                          crossAxisCount: max(min(3, message.images.length + message.videos.length), 1),
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          children: [
                                            ...message.images.map((image) => GestureDetector(
                                              onTap: () => controller.viewImageDetail(index: message.images.indexOf(image)),
                                              child: THelperFunction.getValidImage(
                                                image?.image,
                                                width: 100,
                                                height: 100,
                                                radius: TSize.borderRadiusLg,
                                              ),
                                            )),
                                            ...message.videos.map((video) => GestureDetector(
                                              onTap: () => controller.viewVideoDetail(video),
                                              child:
                                              // VideoThumbnail(videoUrl: video.video)
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [

                                                  Icon(Icons.videocam, size: 80),
                                                  // Icon(Icons.play_arrow, size: 40, color: Colors.white),
                                                ],
                                              )
                                              ,
                                            )),
                                          ],
                                        ),
                                      ),
                                    SizedBox(height: 4),
                                    Align(
                                      alignment: !isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                                      child: Text(
                                        timeago.format(message.createdAt ?? DateTime.now()),
                                        style: Get.textTheme.bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // if(isCurrentUser)...[
                              //   SizedBox(width: TSize.spaceBetweenItemsHorizontal,),
                              //   ClipRRect(
                              //     borderRadius:
                              //     BorderRadius.circular(TSize.borderRadiusCircle),
                              //     child: THelperFunction.getValidImage(
                              //       message.user?.avatar,
                              //       width: 50,
                              //       height: 50,
                              //     ),
                              //   ),
                              // ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ),
              _buildMediaPreview(controller),
              _buildInputRow(controller),
            ],
          ),
        )
        );
      },
    );
  }

  Widget _buildMediaPreview(MessageRoomController controller) {
    return Obx(() {
      if (controller.selectedImages.isEmpty && controller.selectedVideos.isEmpty) {
        return SizedBox.shrink();
      }
      return Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.selectedImages.length + controller.selectedVideos.length,
          itemBuilder: (context, index) {
            if (index < controller.selectedImages.length) {
              return _buildImagePreview(controller, index);
            } else {
              return _buildVideoPreview(controller, index - controller.selectedImages.length);
            }
          },
        ),
      );
    });
  }

  Widget _buildImagePreview(MessageRoomController controller, int index) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => controller.viewImageDetail(index: index),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(TSize.borderRadiusLg),
              child: Image.file(
                File(controller.selectedImages[index].path),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
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
  }

  Widget _buildVideoPreview(MessageRoomController controller, int videoIndex) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => controller.viewVideoDetail(controller.selectedVideos[videoIndex].path),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child:
            // VideoThumbnail(videoUrl: controller.selectedVideos[videoIndex].path)
            Stack(
              alignment: Alignment.center,
              children: [

                Icon(Icons.videocam, size: 80),
                // Icon(Icons.play_arrow, size: 40, color: Colors.white),
              ],
            )
            ,
          ),
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

  Widget _buildInputRow(MessageRoomController controller) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.image),
          onPressed: controller.pickImages,
        ),
        // IconButton(
        //   icon: Icon(Icons.videocam),
        //   onPressed: controller.pickVideos,
        // ),
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
    );
  }
}

// class VideoThumbnail extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoThumbnail({Key? key, required this.videoUrl}) : super(key: key);
//
//   @override
//   _VideoThumbnailState createState() => _VideoThumbnailState();
// }
//
// class _VideoThumbnailState extends State<VideoThumbnail> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
//     _initializeVideoPlayerFuture = _controller.initialize();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initializeVideoPlayerFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return Stack(
//             alignment: Alignment.center,
//             children: [
//               AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               ),
//               Icon(Icons.play_arrow, size: 40, color: Colors.white),
//             ],
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
//
// class VideoDetailDialog extends StatefulWidget {
//   final String videoPath;
//
//   const VideoDetailDialog({Key? key, required this.videoPath}) : super(key: key);
//
//   @override
//   _VideoDetailDialogState createState() => _VideoDetailDialogState();
// }
//
// class _VideoDetailDialogState extends State<VideoDetailDialog> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoPath);
//     _initializeVideoPlayerFuture = _controller.initialize();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height * 0.8,
//         child: FutureBuilder(
//           future: _initializeVideoPlayerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     VideoPlayer(_controller),
//                     IconButton(
//                       icon: Icon(
//                         _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                         size: 50,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           if (_controller.value.isPlaying) {
//                             _controller.pause();
//                           } else {
//                             _controller.play();
//                           }
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }