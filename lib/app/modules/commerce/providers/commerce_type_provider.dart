import 'package:get/get.dart';

import '../../../Utils/app_string.dart';
import '../commerce_type_model.dart';

class CommerceTypeProvider extends GetConnect {

  static const API_URL = AppString.BASE_URL;

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return CommerceType.fromJson(map);
      if (map is List)
        return map.map((item) => CommerceType.fromJson(item)).toList();
    };
    httpClient.baseUrl = API_URL;
  }

  // ALL COMMERCE TYPES
  Future<List<CommerceType>> getTypes() async{
    try{
      final response = await get(API_URL+'commerces_types');
      if(response.status.hasError){
        return Future.error(response.statusText.toString());
      }else{
        return response.body['data'];
      }
    } catch(e){
      return Future.error(e.toString());
    }
  }
}
