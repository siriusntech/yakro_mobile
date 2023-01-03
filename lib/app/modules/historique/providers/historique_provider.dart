import 'package:get/get.dart';

import '../historique_model.dart';

class HistoriqueProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Historique.fromJson(map);
      if (map is List)
        return map.map((item) => Historique.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Historique?> getHistorique(int id) async {
    final response = await get('historique/$id');
    return response.body;
  }

  Future<Response<Historique>> postHistorique(Historique historique) async =>
      await post('historique', historique);
  Future<Response> deleteHistorique(int id) async =>
      await delete('historique/$id');
}
