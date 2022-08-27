import 'package:get/get.dart';
import 'package:joke_app/api/service.dart';
import 'package:joke_app/model/joke_model.dart';

class JokeByTypeController extends GetxController {
  var jokeByType = JokeModel().obs;
  var isLoading = true.obs;
  var isInitState = true.obs;

  getJokeByType(String type) async {
    isInitState.value = false;
    isLoading.value = true;
    final response =
        await DioService().getMethod("https://v2.jokeapi.dev/joke/$type");
    jokeByType.value = response!;
    isLoading.value = !isLoading.value;
  }

  refreshGetJokeByType(String type) async {
    await getJokeByType(type);
    isLoading.value = false;
  }
}
