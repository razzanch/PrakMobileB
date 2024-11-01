import 'package:get/get.dart';

import '../modules/create_task_screen/bindings/create_task_screen_binding.dart';
import '../modules/create_task_screen/views/create_task_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/homescreen/bindings/homescreen_binding.dart';
import '../modules/homescreen/views/homescreen_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/widgetbackground/bindings/widgetbackground_binding.dart';
import '../modules/widgetbackground/views/widgetbackground_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOMESCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.WIDGETBACKGROUND,
      page: () => WidgetbackgroundView(),
      binding: WidgetbackgroundBinding(),
    ),
    GetPage(
      name: _Paths.HOMESCREEN,
      page: () => HomescreenView(),
      binding: HomescreenBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TASK_SCREEN,
      page: () => CreateTaskScreenView(isEdit: false),
      binding: CreateTaskScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
