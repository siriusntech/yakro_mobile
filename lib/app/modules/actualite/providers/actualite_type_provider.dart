import 'package:get/get.dart';

import '../actualite_type_model.dart';

class ActualiteTypeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return ActualiteType.fromJson(map);
      if (map is List)
        return map.map((item) => ActualiteType.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<ActualiteType?> getActualiteType(int id) async {
    final response = await get('actualitetype/$id');
    return response.body;
  }

  Future<Response<ActualiteType>> postActualiteType(
          ActualiteType actualitetype) async =>
      await post('actualitetype', actualitetype);
  Future<Response> deleteActualiteType(int id) async =>
      await delete('actualitetype/$id');
}
