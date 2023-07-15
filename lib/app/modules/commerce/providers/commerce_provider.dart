// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:jaime_cocody/app/Utils/app_string.dart';

// import '../commerce_model.dart';

// class CommerceProvider extends GetConnect {

//   static const API_URL = AppString.BASE_URL;

//   @override
//   void onInit() {
//     httpClient.defaultDecoder = (map) {
//       if (map is Map<String, dynamic>) return Commerce.fromJson(map);
//       if (map is List)
//         return map.map((item) => Commerce.fromJson(item)).toList();
//     };
//     httpClient.baseUrl = API_URL;
//   }

//   // ALL COMMERCES
//   Future<List<Commerce>> getCommerces(var page) async{
//     try{
//        final response = await get(API_URL+'commerces');
//        print(response.body.toString());
//        if(response.status.hasError){
//          return Future.error(response.statusText.toString());
//        }else{
//          return commerceFromJson(response.body.toString());
//        }
//     } catch(e){
//       print(e.toString());
//       return Future.error(e.toString());
//     }
//   }
//   // ALL UNREAD COMMERCES
//   Future<List<dynamic>> getUnReadCommerces(var user_id) async{
//     try{
//       final response = await get(API_URL+'un_read_commerces/$user_id');
//       if(response.status.hasError){
//         return Future.error(response.statusText.toString());
//       }else{
//         return response.body['data'];
//       }
//     } catch(e){
//       return Future.error(e.toString());
//     }
//   }
//   // SEARCH BY NAME
//   Future<List<dynamic>> getCommercesByName(var name) async{
//     try{
//       final response = await get(API_URL+"commerces_by_nom/$name");
//       if(response.status.hasError){
//         return Future.error(response.statusText.toString());
//       }else{
//         return response.body['data'];
//       }
//     } catch(e){
//       return Future.error(e.toString());
//     }
//   }
//   // SEARCH BY TYPE
//   Future<List<dynamic>> getCommercesByType(var type) async{
//     try{
//       final response = await get(API_URL+"commerces_by_type/${type.toString()}");
//       if(response.status.hasError){
//         return Future.error(response.statusText.toString());
//       }else{
//         return response.body['data'];
//       }
//     } catch(e){
//       return Future.error(e.toString());
//     }
//   }

// }
