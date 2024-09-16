import 'dart:convert';
import 'package:food_delivery_app/utils/constants/api_constants.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class SocketService<T> {
  WebSocketChannel? _channel;
  final String? endpoint;
  String? incomingMessage;
  Function(String)? handleIncomingMessage;
  bool _isConnected = false;

  SocketService({
    this.endpoint,
    this.incomingMessage,
    this.handleIncomingMessage,
  });

  String url({String? id}) {
    String url = '${APIConstant.baseSocketUrl}/${endpoint ?? APIConstant.getSocketEndpointFor<T>() ?? ''}';

    if (!url.endsWith('/')) {
      url += '/';
    }

    if (id != null && id.isNotEmpty) {
      url += '$id/';
    }

    return url;
  }

  void connect({String? id}) {
    final String serviceUrl = url(id: id);
    _channel = WebSocketChannel.connect(Uri.parse(serviceUrl));
    $print("CONNECT to $serviceUrl");

    _isConnected = true;

    _channel?.stream.listen(
          (message) async {
        if (handleIncomingMessage != null) {
          try {
            await Future.sync(() => handleIncomingMessage!(message));
          } catch (e) {
            $print('Error handling message: $e');
          }
        } else {
          incomingMessage = message;
          $print("Received message: $message");
        }
        $print(message);
      },
      onError: (error) {
        $print('WebSocket error: $error');
        _isConnected = false;
      },
      onDone: () {
        $print('WebSocket connection closed');
        _isConnected = false;
      },
    );
  }

  bool get isConnected => _isConnected;

  void add(dynamic data) {
    if (data != null) {
      _channel?.sink.add(jsonEncode(data));
    }
  }

  void disconnect() {
    if (_channel != null) {
      $print("DISCONNECT");
      _isConnected = false;
      _channel?.sink.close();
    }
  }
}
