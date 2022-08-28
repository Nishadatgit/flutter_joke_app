import 'package:get/get.dart';
import 'package:joke_app/api/service.dart';
import 'package:joke_app/model/weather_model/weather_model.dart';

class WeatherController extends GetxController {
  Rx<WeatherModel> currentWeather = WeatherModel().obs;
  var isUpdated = true.obs;
  RxString currentCity = RxString('Malappuram');

  getWeather(String currentLocation) async {
    isUpdated.value = false;
    final response = await DioService().getWeather(currentLocation);
    if (response != null) {
      currentWeather.value = response;
      isUpdated.value = true;
    } else {
      print('null returned');
      isUpdated.value = true;
    }
  }

  @override
  void onInit() {
    getWeather('Malappuram');
    super.onInit();
  }
}
