import 'package:get/get.dart';

import '../information_model.dart';

class InformationProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Information.fromJson(map);
      if (map is List)
        return map.map((item) => Information.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Information?> getInformation(int id) async {
    final response = await get('information/$id');
    return response.body;
  }

  Future<Response<Information>> postInformation(
          Information information) async =>
      await post('information', information);
  Future<Response> deleteInformation(int id) async =>
      await delete('information/$id');
}
