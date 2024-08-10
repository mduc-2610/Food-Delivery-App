import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/notification/models/message.dart';
import 'package:food_delivery_app/features/notification/models/room.dart';
import 'package:food_delivery_app/utils/constants/api_constants.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:get/get.dart';
//  Tammy Gregory
// 36215434348
//  Carla Clark
// 52501631294
class MessageTabController extends GetxController {
  static MessageTabController get instance => Get.find();
  WebSocketChannel? channel;
  User? user;
  var rooms = <String, DirectRoom>{}.obs;
  Rx<bool> isLoading = true.obs;
  final ScrollController scrollController = ScrollController();
  String? nextPage;

  @override
  void onInit() {
    super.onInit();
    initializeUser();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    super.onClose();
    _disconnectWebSocket();
  }

  void _scrollListener() {
    $print(scrollController.position.pixels);
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreRooms();
    }
  }

  Future<void> loadMoreRooms() async {
    if (nextPage != null) {
      final [_result, _info] = await APIService<DirectRoom>(fullUrl: nextPage!).list(next: true);
      rooms.addAll({for (var room in _result) room.id ?? "x": room});
      nextPage = _info["next"];
      rooms.refresh();
    } else {
      print("Reached the end of messages");
    }
  }

  Future<void> initializeUser() async {
    user = await UserService.getUser();
    if(user != null) {
      _connectWebSocket();
    }
    await initializeRoom();
  }

  Future<void> initializeRoom() async {
    if (user?.user2Rooms != null) {
      final [_result, _info] = await APIService<DirectRoom>(fullUrl: user?.user2Rooms ?? "").list(next: true);
      final [_result2, _info2] = await APIService<DirectRoom>(fullUrl: user?.user1Rooms ?? "").list(next: true);
      rooms.value = {for (var room in _result) room.id ?? "x": room};
      rooms.addAll({for (var room in _result2) room.id ?? "x" : room});
      nextPage = _info["next"];
      rooms.refresh();
    }
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  Future<void> _connectWebSocket() async {
      try {
        channel = WebSocketChannel.connect(
          Uri.parse('${APIConstant.baseSocketUrl}/chat/'),
        );
        $print("ROOM LIST SOCKET");

        channel?.stream.listen((message) {
          $print("ROOM Message");
          $print(message);
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

  void _handleIncomingMessage(String message) {
    final _message = DirectMessage.fromJson(jsonDecode(message)["message"]);
    final roomId = _message.room;
    if (rooms.containsKey(roomId)) {
      final room = rooms[roomId];
      if (room != null && roomId != null) {
        room.latestMessage = _message;
        rooms[roomId] = room;
        rooms.refresh();
      }
    }
  }

    void _disconnectWebSocket() {
      channel?.sink.close(status.normalClosure);
      $print("CLOSE ROOM LIST SOCKET");
    }
}
