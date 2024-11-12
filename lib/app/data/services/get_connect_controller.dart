import 'package:get/get.dart';
import '../models/article.dart';

class GetConnectController extends GetConnect {
  static const String _baseUrl = 'https://my-json-server.typicode.com/Fallid/codelab-api/db';
  static const String _apiKey = '63a0dcceb44e42f2bfe3c3501a817e5d'; // Ganti ke API KEY yang sudah didapat
  static const String _category = 'business';
  static const String _country = 'us'; //us maksudnya United States ya

  RxList<ArticleElement> articles = RxList<ArticleElement>([]); // Perubahan di sini
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true; // set loading state to true
      final response = await get(
          '${_baseUrl}?country=$_country&category=$_category&apiKey=$_apiKey');

      if (response.statusCode == 200) {
        final articlesResult = Article.fromJson(response.body); // Perubahan di sini
        articles.value = articlesResult.articles; // Perubahan di sini
      } else {
        print("Request failed with status ${response.statusCode}");
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      isLoading.value = false; // set status loading to false when it done
    }
  }
}
