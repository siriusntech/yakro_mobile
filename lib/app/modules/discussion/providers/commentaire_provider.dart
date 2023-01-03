import 'package:get/get.dart';

import '../commentaire_model.dart';

class CommentaireProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Commentaire.fromJson(map);
      if (map is List)
        return map.map((item) => Commentaire.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Commentaire?> getCommentaire(int id) async {
    final response = await get('commentaire/$id');
    return response.body;
  }

  Future<Response<Commentaire>> postCommentaire(
          Commentaire commentaire) async =>
      await post('commentaire', commentaire);
  Future<Response> deleteCommentaire(int id) async =>
      await delete('commentaire/$id');
}
