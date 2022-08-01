import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hotline/bindings/hotline_binding.dart';
import '../modules/hotline/views/hotline_view.dart';
import '../modules/internasional/bindings/internasional_binding.dart';
import '../modules/internasional/views/internasional_view.dart';
import '../modules/rujukan/bindings/rujukan_binding.dart';
import '../modules/rujukan/views/rujukan_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RUJUKAN,
      page: () => RujukanView(),
      binding: RujukanBinding(),
    ),
    GetPage(
      name: _Paths.HOTLINE,
      page: () => const HotlineView(),
      binding: HotlineBinding(),
    ),
    GetPage(
      name: _Paths.INTERNASIONAL,
      page: () => const InternasionalView(),
      binding: InternasionalBinding(),
    ),
  ];
}
