import 'package:get/get.dart';

import '../actualite_model.dart';

class ActualiteProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Actualite.fromJson(map);
      if (map is List)
        return map.map((item) => Actualite.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Actualite?> getActualite(int id) async {
    final response = await get('actualite/$id');
    return response.body;
  }

  Future<Response<Actualite>> postActualite(Actualite actualite) async =>
      await post('actualite', actualite);
  Future<Response> deleteActualite(int id) async =>
      await delete('actualite/$id');
}
