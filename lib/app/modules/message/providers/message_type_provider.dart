import 'package:get/get.dart';

import '../message_type_model.dart';

class MessageTypeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return MessageType.fromJson(map);
      if (map is List)
        return map.map((item) => MessageType.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<MessageType?> getMessageType(int id) async {
    final response = await get('messagetype/$id');
    return response.body;
  }

  Future<Response<MessageType>> postMessageType(
          MessageType messagetype) async =>
      await post('messagetype', messagetype);
  Future<Response> deleteMessageType(int id) async =>
      await delete('messagetype/$id');
}
