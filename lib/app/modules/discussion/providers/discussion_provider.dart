import 'package:get/get.dart';

import '../discussion_model.dart';

class DiscussionProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Discussion.fromJson(map);
      if (map is List)
        return map.map((item) => Discussion.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Discussion?> getDiscussion(int id) async {
    final response = await get('discussion/$id');
    return response.body;
  }

  Future<Response<Discussion>> postDiscussion(Discussion discussion) async =>
      await post('discussion', discussion);
  Future<Response> deleteDiscussion(int id) async =>
      await delete('discussion/$id');
}
