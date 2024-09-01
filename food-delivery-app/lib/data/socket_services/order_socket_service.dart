import 'dart:convert';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/api_constants.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class OrderSocketService {
  WebSocketChannel? _channel;

  void connect() {
      final String url = '${APIConstant.baseSocketUrl}/order/';
      _channel = WebSocketChannel.connect(Uri.parse(url));
      $print("CONNECT");
      _channel?.stream.listen(
            (message) {
          handleIncomingMessage(message);
          $print(message);
        },
        onError: (error) {
          print('WebSocket error: $error');
        },
        onDone: () {
          print('WebSocket connection closed');
        },
      );

  }

  void sendMessage(Map<String, dynamic> data) {
      _channel?.sink.add(jsonEncode(data));
      $print(jsonEncode(data));
  }

  void handleIncomingMessage(String message) {
    // Order? order = Order.fromJson(jsonDecode(message)["order"]);
    $print("asdasd");
    $print(message);
  }

  void disconnect() {
    if (_channel != null) {
      _channel?.sink.close();
      $print("DISCONNECT");
    }
  }
}
