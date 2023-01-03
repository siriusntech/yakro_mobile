import 'package:get/get.dart';

import '../diffusion_model.dart';

class DiffusionProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Diffusion.fromJson(map);
      if (map is List)
        return map.map((item) => Diffusion.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Diffusion?> getDiffusion(int id) async {
    final response = await get('diffusion/$id');
    return response.body;
  }

  Future<Response<Diffusion>> postDiffusion(Diffusion diffusion) async =>
      await post('diffusion', diffusion);
  Future<Response> deleteDiffusion(int id) async =>
      await delete('diffusion/$id');
}
