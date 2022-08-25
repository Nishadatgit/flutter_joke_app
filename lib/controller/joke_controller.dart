import 'package:get/get.dart';
import 'package:joke_app/api/service.dart';
import 'package:joke_app/model/joke_model.dart';

class JokeController extends GetxController {
  var joke = JokeModel(
          category: 'None',
          setup: 'Fetching data for you...',
          delivery: '',
          joke: 'Fetching data for you...')
      .obs;
  var isLoading = true.obs;

  getJoke() async {
    final response =
        await DioService().getMethod("https://v2.jokeapi.dev/joke/any");
    isLoading.value = !isLoading.value;

    joke.value = response ??
        JokeModel(
            category: 'None',
            setup: 'Fetching data for you...',
            delivery: '',
            joke: '');
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
