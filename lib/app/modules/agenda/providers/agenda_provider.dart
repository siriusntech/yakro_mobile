import 'package:get/get.dart';

import '../agenda_model.dart';

class AgendaProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Agenda.fromJson(map);
      if (map is List) return map.map((item) => Agenda.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Agenda?> getAgenda(int id) async {
    final response = await get('agenda/$id');
    return response.body;
  }

  Future<Response<Agenda>> postAgenda(Agenda agenda) async =>
      await post('agenda', agenda);
  Future<Response> deleteAgenda(int id) async => await delete('agenda/$id');
}
