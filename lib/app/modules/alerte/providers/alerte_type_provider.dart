import 'package:get/get.dart';

import '../alerte_type_model.dart';

class AlerteTypeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return AlerteType.fromJson(map);
      if (map is List)
        return map.map((item) => AlerteType.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<AlerteType?> getAlerteType(int id) async {
    final response = await get('alertetype/$id');
    return response.body;
  }

  Future<Response<AlerteType>> postAlerteType(AlerteType alertetype) async =>
      await post('alertetype', alertetype);
  Future<Response> deleteAlerteType(int id) async =>
      await delete('alertetype/$id');
}
