import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/empty.dart';
import 'package:timeago/timeago.dart' as timesago;
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/sliver_sized_box.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/features/user/food/models/review/review_reply.dart';
import 'package:food_delivery_app/features/user/food/views/review/detail_review.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DetailReviewList extends StatelessWidget {
  final String filter;
  final dynamic controller;
  final ReviewType reviewType;
  final ViewType viewType;

  const DetailReviewList({
    Key? key,
    required this.filter,
    required this.controller,
    this.reviewType = ReviewType.food,
    this.viewType = ViewType.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("Building DetailReviewList with ${controller.reviews.length} reviews");
      return CustomScrollView(
        slivers: [
          (controller.reviews.length == 0)
          ?  SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: TSize.spaceBetweenItemsXl,),
                  EmptyWidget(
                    message: "No reviews available",
                  ),
                ],
              ),
            )

          : SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                if (index >= controller.reviews.length) {
                  controller.loadMoreReviews(filter: filter);
                  return SizedBox();
                }

                final review = controller.reviews[index];
                return Column(
                  children: [
                    _buildReviewWidget(review, context, index),
                    SeparateSectionBar(),
                  ],
                );
              },
              childCount: controller.reviews.length + 1,
            ),
          ),
          SliverSizedBox(height: TSize.spaceBetweenSections),
          SliverSizedBox(height: TSize.spaceBetweenItemsVertical),
        ],
      );
    });
  }

  Widget _buildReviewWidget(review, BuildContext context, int index, { bool displayReply = true, bool displayInteract = true}) {
    return MainWrapperSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(TSize.borderRadiusCircle),
                    child: THelperFunction.getValidImage(
                      review?.user?.avatar,
                      width: TSize.imageSm,
                      height: TSize.imageSm,
                    )
                  ),
                  SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${review.user?.name ?? ""}"),
                      Text("${timesago.format(review.createdAt ?? DateTime.now())}"),
                    ],
                  )
                ],
              ),
              RatingBarIndicator(
                rating: (review.rating ?? 0).toDouble(),
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
              Text(
                "${review.title ?? ""}",
                style: Get.textTheme.titleLarge,
              ),
              SizedBox(height: TSize.spaceBetweenItemsSm),
              Text(
                "${review.content ?? ""}",
                style: Get.textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical),

          if (review.images != null && review.images!.isNotEmpty) ...[
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: TSize.spaceBetweenItemsHorizontal,
              mainAxisSpacing: TSize.spaceBetweenItemsVertical,
              children: review.images!.map<Widget>((image) {
                return THelperFunction.getValidImage(
                  image.image,
                  width: (MediaQuery.of(context).size.width - (TSize.spaceBetweenItemsHorizontal * 3)) / 4,
                  height: (MediaQuery.of(context).size.width - (TSize.spaceBetweenItemsHorizontal * 3)) / 4,
                  radius: TSize.borderRadiusMd,
                );
              }).toList(),
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
          ],

          if(displayInteract)...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.toggleLike(review);
                  },
                  child: Row(
                    children: [
                      Icon(
                        review.isLiked.value ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                        color: review.isLiked.value ? Colors.blue : Colors.grey,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      Text("${review.totalLikes.value}"),
                    ],
                  ),
                ),
                if(viewType == ViewType.restaurant || viewType == ViewType.deliverer)
                  InkWell(
                    onTap: () {
                      _showReplyDialog(context, review, index);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.reply,
                          color: Colors.grey,
                        ),
                        SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                        Text("Reply"),
                      ],
                    ),
                  ),
              ],
            ),
          ],

          if (displayReply)
            Obx(() {
              if (review.replies != null && review.replies!.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: TSize.spaceBetweenItemsVertical),
                  child: Column(
                    children: [
                      for(int i = 0; i < review.replies.length; i++) ...[
                        _buildReplyWidget(review.replies[i], review, index, i, context),
                      ]
                    ],
                  ),
                );
              } else {
                return SizedBox(); // Or any placeholder if needed
              }
            }),

          // SizedBox(height: TSize.spaceBetweenSections),
        ],
      ),
    );
  }

  Widget _buildReplyWidget(dynamic reply, dynamic review, int parentIndex, int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: TSize.spaceBetweenItemsSm),
      padding: EdgeInsets.all(TSize.spaceBetweenItemsMd),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reply from ${_getReplyFrom()}",
                    style: Get.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${timesago.format(reply.createdAt ?? DateTime.now())}",
                    style: Get.textTheme.bodySmall,
                  ),
                ],
              ),
              if(viewType == ViewType.deliverer || viewType == ViewType.restaurant)...[
                PopupMenuButton<String>(
                  icon: CircleIconCard(
                    icon: Icons.more_horiz,
                  ),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      onTap: () async {
                        try {
                          var result = await controller.callCreateUpdateDeleteReviewReply(
                            null,
                            isFormData: true,
                            id: reply?.id,
                            delete: true,
                          );
                          if(result) {
                            Get.snackbar(
                                "Success",
                                "Successfully delete",
                                backgroundColor: TColor.successSnackBar
                            );
                            controller.reviews[parentIndex].replies.removeAt(index);

                          }
                          else {
                            Get.snackbar(
                                "Error",
                                "Can't find the reply you asked",
                                backgroundColor: TColor.errorSnackBar
                            );
                          }
                        }
                        catch(e) {
                          $print(e);
                          Get.snackbar(
                              "Error",
                              "An error occurred while delete",
                              backgroundColor: TColor.errorSnackBar
                          );
                        }
                      },
                      value: 'toggle',
                      child: Text(
                        "Delete this reply",
                        style: Get.theme.textTheme.bodyMedium,
                      ),
                    ),
                    PopupMenuItem<String>(
                      onTap: () {
                        _showReplyDialog(context, review, parentIndex, reply: reply);
                        print("EDIT THIS");
                      },
                      value: 'edit',
                      child: Text(
                        'Edit this reply',
                        style: Get.theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
          Divider(),
          Text(
            "${reply.title ?? ""}",
            style: Get.textTheme.titleLarge,
          ),
          SizedBox(height: TSize.spaceBetweenItemsSm),
          Text(
            reply.content ?? "",
            style: Get.textTheme.bodyMedium,
          ),
          SizedBox(height: TSize.spaceBetweenItemsSm),

          if (reply.images != null && reply.images!.isNotEmpty) ...[
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: TSize.spaceBetweenItemsHorizontal,
              mainAxisSpacing: TSize.spaceBetweenItemsVertical,
              children: reply.images!.map<Widget>((image) {
                return THelperFunction.getValidImage(
                  image.image,
                  width: (MediaQuery.of(context).size.width - (TSize.spaceBetweenItemsHorizontal * 3)) / 4,
                  height: (MediaQuery.of(context).size.width - (TSize.spaceBetweenItemsHorizontal * 3)) / 4,
                  radius: TSize.borderRadiusMd,
                );
              }).toList(),
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
          ],
        ],
      ),
    );
  }

  void _showReplyDialog(BuildContext context, dynamic review, int index, { dynamic reply }) {
    final titleController = TextEditingController();
    final replyController = TextEditingController();
    List databaseImages = [];
    if(reply != null) {
      titleController.text = reply?.title ?? "";
      replyController.text = reply?.content ?? "";
      databaseImages = reply?.images?.map((image) => image.image).toList() ?? [];
    }

    final replyDocumentController = Get.put(
        RegistrationDocumentFieldController(
          databaseImages: databaseImages,
          maxLength: 4,
        ),
        tag: "${index}"
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: MainWrapper(
                    topMargin: TSize.spaceBetweenItemsVertical,
                    child: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildReviewWidget(
                            review,
                            context,
                            index,
                            displayReply: false,
                            displayInteract: false,
                          ),
                          Text(
                            "Reply",
                            style: Get.textTheme.headlineSmall,
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsVertical),

                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(hintText: "Enter your title (optional)"),
                            maxLines: 3,
                            maxLength: 100,
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsVertical),

                          TextField(
                            controller: replyController,
                            decoration: InputDecoration(hintText: "Enter your reply"),
                            maxLines: 5,
                            maxLength: 300,
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsVertical),

                          RegistrationDocumentField(
                            controller: replyDocumentController,
                            label: "Upload image (optional)",
                            highlight: false,
                            crossAxisCount: 2,
                            imageWidth: 145,
                            viewEx: false,
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsVertical),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: SingleChildScrollView(
                  child: MainWrapper(
                    topMargin: TSize.spaceBetweenItemsSm,
                    bottomMargin: TSize.spaceBetweenItemsMd,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SmallButton(
                          text: "Cancel",
                          textColor: TColor.dark,
                          onPressed: () {
                            Get.back();
                            replyDocumentController.selectedImages.value = [];
                            titleController.text = "";
                            replyController.text = "";
                          },
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                        SmallButton(
                            text: "Submit",
                            onPressed: () async {
                              Get.back();
                              print("CURRENT REPLY $reply");
                              try {
                                final reviewReplyData = _createReviewReplyData(
                                  titleController.text,
                                  replyController.text,
                                  replyDocumentController.selectedImages,
                                  review?.id,
                                );
                                if(reply == null) {
                                  await _handleNewReply(reviewReplyData, index);
                                }
                                else {
                                  await _handleExistingReply(reviewReplyData, reply, index);
                                }
                              }
                              catch(e) {
                                print(e);
                                Get.snackbar(
                                  "Error",
                                  "An error occurred",
                                  backgroundColor: TColor.errorSnackBar,
                                );
                              }
                              replyDocumentController.selectedImages.value = [];
                              titleController.text = "";
                              replyController.text = "";

                            }
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getReplyFrom() {
    return viewType == ViewType.restaurant ? 'Restaurant' : 'Deliverer';
  }

  dynamic _createReviewReplyData(String title, String content, List<dynamic> images, String? reviewId) {
    if (viewType == ViewType.restaurant) {
      return RestaurantReviewReply(
        user: controller.user,
        review: reviewId,
        title: title,
        content: content,
        images: images,
      );
    } else {
      return DelivererReviewReply(
        user: controller.user,
        review: reviewId,
        title: title,
        content: content,
        images: images,
      );
    }
  }

  Future<void> _handleNewReply(dynamic reviewReplyData, int index) async {
    final [statusCode, headers, data] = await controller.callCreateUpdateDeleteReviewReply(
      reviewReplyData,
      isFormData: true,
    );
    controller.reviews[index].replies.add(data);
    controller.reviews[index].replies.refresh();
    print("new len: ${controller.reviews[index].replies.length}");
    Get.snackbar(
      "Success",
      "Successfully posted your reply",
      backgroundColor: TColor.successSnackBar,
    );
  }

  Future<void> _handleExistingReply(dynamic reviewReplyData, dynamic reply, int index) async {
    if(reply?.id != null) {
      print(reviewReplyData);
      final [statusCode, headers, data] = await controller.callCreateUpdateDeleteReviewReply(
          reviewReplyData,
          isFormData: true,
          id: reply?.id
      );
      int _index = controller.reviews[index].replies
          .indexWhere((r) => r?.id == data?.id);
      if(_index != -1) {
        controller.reviews[index].replies[_index] = data;
      }
      Get.snackbar(
        "Success",
        "Successfully updated your reply",
        backgroundColor: TColor.successSnackBar,
      );
    }
    else {
      Get.snackbar(
        "Error",
        "Reply not found",
        backgroundColor: TColor.errorSnackBar,
      );
    }
  }
}
