import 'dart:convert';
import 'dart:io';
import 'package:food_delivery_app/common/widgets/dialogs/image_detail_dialog.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/data/services/image_picker_service.dart';
import 'package:food_delivery_app/features/notification/controllers/message_tab_controller.dart';
import 'package:food_delivery_app/features/notification/models/room.dart';
import 'package:food_delivery_app/features/personal/views/profile/profile.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/notification/models/message.dart';
import 'package:food_delivery_app/utils/constants/api_constants.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:dio/dio.dart';


class MessageRoomController extends GetxController {
  Rx<bool> isLoading = true.obs;
  WebSocketChannel? _channel;
  WebSocketChannel? _channel2;
  late final messageTabController ;
  final ViewType viewType;

  var _messages = <DirectMessage>[].obs;
  String? roomId;
  final TextEditingController textController = TextEditingController();
  var _selectedImages = <XFile>[].obs;
  var _selectedVideos = <XFile>[].obs;
  ImagePickerService pickerService = ImagePickerService();
  User? currentUser;
  DirectRoom? room;
  final ScrollController scrollController = ScrollController();

  List<DirectMessage> get messages => _messages;
  List<XFile> get selectedImages => _selectedImages;
  List<XFile> get selectedVideos => _selectedVideos;
  String? nextPage;

  String? user1Id, user2Id;

  MessageRoomController({ this.viewType = ViewType.user });

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    if(arguments != null) {
      roomId = arguments['id'];
      user1Id = arguments['user1Id'];
      user2Id = arguments['user2Id'];
    }
    $print("User1Id: $user1Id : \nUser2Id: $user2Id");
    try {
      messageTabController = MessageTabController.instance;
     _channel2 = messageTabController.channel;
    }
    catch(e) {
      _connectWebSocket2();
    }

    initialize();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    textController.dispose();
    _disconnectWebSocket();
    super.onClose();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    await initializeUser();
    await initializeMessage(roomId: roomId, user1Id: user1Id, user2Id: user2Id);
    isLoading.value = false;
  }

  Future<void> _connectWebSocket2() async {
    try {
      _channel2 = WebSocketChannel.connect(
        Uri.parse('${APIConstant.baseSocketUrl}/chat/'),
      );
      $print("ROOM LIST SOCKET");

      _channel2?.stream.listen((message) {
        $print("ROOM Message");
        $print(message);
        // _handleIncomingMessage(message);
      }, onError: (error) {
        print('WebSocket Error: $error');
      }, onDone: () {
        print('WebSocket Closed');
      });
    } catch (e) {
      print('WebSocket Exception: $e');
    }
  }

  Future<void> initializeUser() async {
    currentUser = await UserService.getUser();
    if (currentUser != null) {
      _connectWebSocket();
    } else {
      print('Failed to fetch current user');
    }
  }

  Future<void> initializeMessage({ String? roomId, String? user1Id, String? user2Id}) async {
    if (roomId != null) {
      room = await APIService<DirectRoom>().retrieve(roomId);
    }
    else if(user1Id != null && user2Id != null) {
      try {
        String params = "user1=$user1Id&user2=$user2Id" +
            ((viewType == ViewType.deliverer)
                ? "&name_type=deliverer"
                : (viewType == ViewType.restaurant)
                ? "&name_type=restaurant"
                : "");
        $print("PARAMS: $params");
        var rooms = (await APIService<DirectRoom>(queryParams: params).list());
        if(rooms.isNotEmpty) {
          room = rooms.first;
        }
        else {
          final roomData = DirectRoom(
            user1: user1Id,
            user2: user2Id,
          );
          $print(roomData);
          final [statusCode, headers, data] = await APIService<DirectRoom>().create(roomData);
          room = data;
        }
      }
      catch(e) {
        room == null;
      }
    }
    $print("ROOM MESSAGES: ${room?.messages}");
    if(room?.messages != null) {
      final [_result, _info] = await APIService<DirectMessage>(fullUrl: room?.messages ?? "").list(next: true);
      nextPage = _info["next"];
      _messages.addAll(_result);
    }
    update();
  }

  void scrollToBottom({bool force = false}) {
    scrollController.jumpTo(scrollController.position.minScrollExtent);
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreMessages();
    }
  }

  Future<void> loadMoreMessages() async {
    if(nextPage != null) {
      final [_result, _info] = await APIService<DirectMessage>(fullUrl: nextPage!).list(next: true);
      nextPage = _info["next"];
      _messages.addAll(_result);
    } else {
      print("Reached the end of messages");
    }
  }

  void _connectWebSocket() async {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('${APIConstant.baseSocketUrl}/chat/$roomId/'),
      );

      _channel!.stream.listen((message) {
        _handleIncomingMessage(message);
      }, onError: (error) {
        print('WebSocket Error: $error');
      }, onDone: () {
        print('WebSocket Closed');
      });
    } catch (e) {
      print('WebSocket Exception: $e');
    }
  }

  void _disconnectWebSocket() {
    _channel?.sink.close(status.normalClosure);
    $print("DISCONNECT CHAT SOCKET");
  }

  void _handleIncomingMessage(String message) {
    final _message = DirectMessage.fromJson(jsonDecode(message)["message"]);
    _messages.insert(0, _message);
  }

  Future<void> sendMessage() async {
    if (currentUser == null) return;
    String content = textController.text;
    final [statusCode, headers, data] = await _sendMessage(
      currentUser?.id ?? "",
      content,
      _selectedImages,
      _selectedVideos,
    );
    _channel?.sink.add(jsonEncode(data));
    _channel2?.sink.add(jsonEncode(data));
    textController.clear();
    _selectedImages.clear();
    _selectedVideos.clear();
    scrollToBottom(force: true);
  }

  Future<dynamic> _sendMessage(String userId, String content, List<XFile> selectedImages, List<XFile> selectedVideos) async {
    final x = DirectMessage(
      user: userId,
      room: room?.id,
      content: content,
      images: selectedImages,
      videos: selectedVideos,
    );

    final response = await APIService<DirectMessage>(dio: Dio())
        .create(x, isFormData: true, noBearer: true, noFromJson: true);
    return response;
  }


  Future<void> pickImages() async {
    List<XFile> images = await pickerService.pickImages();
    _selectedImages.addAll(images);
  }

  Future<void> pickVideos() async {
    List<XFile> videos = await pickerService.pickVideos();
    _selectedVideos.addAll(videos);
  }

  void removeImage(int index) {
    _selectedImages.removeAt(index);
  }

  void removeVideo(int index) {
    _selectedVideos.removeAt(index);
  }

  void viewImageDetail({int index = 0}) {
    List<dynamic> allImages = [];

    allImages.addAll(selectedImages);

    allImages.addAll(
      messages.expand((message) => message.images.map((image) => image.image).toList()).toList(),
    );

    $print("LEN IMAGES: ${allImages.length}");
    showDialog(
      context: Get.context!,
      useSafeArea: false,
      barrierColor: TColor.dark.withOpacity(0.1),
      builder: (BuildContext context) => ImageDetailDialog(
        images: allImages,
        initialIndex: index,
      ),
    );
  }


  void viewVideoDetail(String videoPath) {
    showDialog(
      context: Get.context!,
      useSafeArea: false,
      barrierColor: TColor.dark.withOpacity(0.1),
      builder: (BuildContext context) => VideoDetailDialog(videoPath: videoPath),
    );
  }

  void showDeleteModal(BuildContext context, MessageRoomController controller, DirectMessage message) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: MainWrapper(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete Message'),
                  onTap: () {
                    Navigator.pop(context);
                    deleteMessage(message);
                  },
                ),
                SizedBox(height: TSize.spaceBetweenSections,)
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteMessage(DirectMessage? message) async {
    try {
      bool result = await APIService<DirectMessage>().delete(message?.id ?? '');
      if (result) {
        _messages.remove(message);
        Get.snackbar(
          'Success',
          'Message deleted successfully',
          backgroundColor: TColor.successSnackBar,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete message',
          backgroundColor: TColor.errorSnackBar,
        );
      }
    } catch (e) {
      print('Error deleting message: $e');
      Get.snackbar(
        'Error',
        'An error occurred while deleting the message',
        backgroundColor: TColor.errorSnackBar,
      );
    }
  }
}

class VideoDetailDialog extends StatelessWidget {
  final String videoPath;

  const VideoDetailDialog({Key? key, required this.videoPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Center(
          child: Text("Video Player: $videoPath"),
        ),
      ),
    );
  }
}