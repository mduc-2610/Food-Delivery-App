import 'dart:convert';
import 'dart:io';
import 'package:food_delivery_app/data/services/image_picker_service.dart';
import 'package:food_delivery_app/features/notification/controllers/message_tab_controller.dart';
import 'package:food_delivery_app/features/notification/models/room.dart';
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
  WebSocketChannel? _channel;
  WebSocketChannel? _channel2;
  final messageTabController = MessageTabController.instance;

  var _messages = <DirectMessage>[].obs;
  String? roomName;
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

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null) {
      roomName = Get.arguments['id'];
    }
    _channel2 = messageTabController.channel;
    initializeUser();
    initializeMessage();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    textController.dispose();
    _disconnectWebSocket();
    super.onClose();
  }

  Future<void> initializeUser() async {
    currentUser = await UserService.getUser();
    if (currentUser != null) {
      _connectWebSocket();
    } else {
      print('Failed to fetch current user');
    }
  }

  Future<void> initializeMessage() async {
    room = await APIService<DirectRoom>().retrieve(roomName ?? "");
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
        Uri.parse('${APIConstant.baseSocketUrl}/chat/$roomName/'),
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
    final data = await _sendMessage(
      currentUser?.id ?? "",
      content,
      _selectedImages,
      _selectedVideos,
    );
    _channel?.sink.add(jsonEncode(data[2]));
    _channel2?.sink.add(jsonEncode(data[2]));
    textController.clear();
    _selectedImages.clear();
    _selectedVideos.clear();
    scrollToBottom(force: true);
  }

  Future<dynamic> _sendMessage(String userId, String content, List<XFile> selectedImages, List<XFile> selectedVideos) async {
    final x = DirectMessage(
      user: userId,
      room: roomName,
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
}
