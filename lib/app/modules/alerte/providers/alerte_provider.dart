import 'package:get/get.dart';

import '../alerte_model.dart';

class AlerteProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Alerte.fromJson(map);
      if (map is List) return map.map((item) => Alerte.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Alerte?> getAlerte(int id) async {
    final response = await get('alerte/$id');
    return response.body;
  }

  Future<Response<Alerte>> postAlerte(Alerte alerte) async =>
      await post('alerte', alerte);
  Future<Response> deleteAlerte(int id) async => await delete('alerte/$id');
}
