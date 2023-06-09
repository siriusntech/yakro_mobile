// import 'package:get/get.dart';

// import '../hotel_model_model.dart';

// class HotelModelProvider extends GetConnect {
//   @override
//   void onInit() {
//     httpClient.defaultDecoder = (map) {
//       if (map is Map<String, dynamic>) return HotelModel.fromJson(map);
//       if (map is List)
//         return map.map((item) => HotelModel.fromJson(item)).toList();
//     };
//     httpClient.baseUrl =
//         'https://sdyakro.siriusntech.digital/api/mobile/hotelsIndex';
//   }

//   Future<HotelModel?> getHotelModel(int id) async {
//     final response = await get('hotelmodel/$id');
//     return response.body;
//   }

//   Future<Response<HotelModel>> postHotelModel(HotelModel hotelmodel) async =>
//       await post('hotelmodel', hotelmodel);
//   Future<Response> deleteHotelModel(int id) async =>
//       await delete('hotelmodel/$id');
// }
