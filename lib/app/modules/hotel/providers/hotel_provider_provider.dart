import 'package:get/get.dart';

class HotelProviderProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl =
        'https://sdyakro.siriusntech.digital/api/mobile/hotelsIndex';
  }
}
