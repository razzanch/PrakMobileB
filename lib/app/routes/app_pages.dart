import 'package:get/get.dart';
import 'package:myapp/app/modules/connection/views/no_connection_view.dart';

import '../modules/article_detail/bindings/article_detail_binding.dart';
import '../modules/article_detail/views/article_detail_view.dart';
import '../modules/article_detail/views/article_detail_web_view.dart';
import '../modules/connection/bindings/connection_binding.dart';
import '../modules/get_connect/bindings/get_connect_binding.dart';
import '../modules/get_connect/views/get_connect_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GET_CONNECT,
      page: () => const GetConnectView(),
      binding: GetConnectBinding(),
    ),
    GetPage(
        name: _Paths.ARTICLE_DETAIL,
        page: () => ArticleDetailView(article: Get.arguments),
        binding: ArticleDetailBinding()),
    GetPage(
        name: _Paths.ARTICLE_DETAIL_WEBVIEW,
        page: () => ArticleDetailWebView(article: Get.arguments),
        binding: ArticleDetailBinding()),
    GetPage(
      name: _Paths.CONNECTION,
      page: () => const NoConnectionView(),
      binding: ConnectionBinding(),
    ),
  ];
}
