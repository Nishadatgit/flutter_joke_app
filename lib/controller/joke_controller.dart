import 'package:get/get.dart';
import 'package:joke_app/api/service.dart';
import 'package:joke_app/model/joke_model.dart';

class JokeController extends GetxController {
  var joke = JokeModel().obs;

  var isLoading = true.obs;

  getJoke() async {
    final response =
        await DioService().getMethod("https://v2.jokeapi.dev/joke/any");

    joke.value = response!;
    isLoading.value = !isLoading.value;
  }

  Future<void> refreshItems() async {
    isLoading.value = true;
    await getJoke();
  }

  @override
  void onInit() {
    getJoke();
    super.onInit();
  }
}
