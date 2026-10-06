import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/work_order.dart';
import '../screens/history_screen.dart';
import '../screens/inspection_form_screen.dart';
import '../screens/login_screen.dart';
import '../screens/work_orders_screen.dart';
import '../screens/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
      AutoRoute(page: SplashRoute.page, path: '/', initial: true),
      AutoRoute(page: LoginRoute.page, path: '/login'),
      AutoRoute(page: WorkOrdersRoute.page, path: '/work-orders'),
      AutoRoute(page: HistoryRoute.page, path: '/history'),
      AutoRoute(page: InspectionFormRoute.page, path: '/inspection'),

      ];
}