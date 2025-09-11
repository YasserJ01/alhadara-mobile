// lib/core/services/news_feed_socket_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:project2/core/services/token_service.dart';
import '../../features/enrollment/data/models/news_feed_model.dart';
import '../../features/enrollment/domain/entities/news_feed_entity.dart';

class NewsFeedSocketService {
  final int scheduleSlotId;
  WebSocketChannel? _channel;
  StreamController<NewsFeedEntity> _controller = StreamController.broadcast();
  NewsFeedSocketService(this.scheduleSlotId);
  Stream<NewsFeedEntity> get stream => _controller.stream;
  Future<void> connect() async {
    final token = await TokenService.getAccessToken();
    // final url = 'ws://10.0.2.2:8000/ws/news/$scheduleSlotId/?token=$token';
    // final url = 'ws://192.168.1.3:8000/ws/news/$scheduleSlotId/?token=$token';
    final url = 'wss://optimum-kodiak-hardy.ngrok-free.app/ws/news/$scheduleSlotId/?token=$token';

    _channel = WebSocketChannel.connect(Uri.parse(url));
    _channel!.stream.listen(
      (message) => _handleMessage(message),
      onError: (error) => print('WebSocket error: $error'),
      onDone: () => _reconnect(),
    );
  }

  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message);
      if (data['type'] == 'new_item') {
        final item = NewsFeedModel.fromJson(data['notification']).toEntity();
        _controller.add(item);
      }
    } catch (e) {
      print('Failed to parse message: $e');
    }
  }

  void _reconnect() {
    Future.delayed(Duration(seconds: 5), () => connect());
  }

  void dispose() {
    _channel?.sink.close();
    _controller.close();
  }
}
