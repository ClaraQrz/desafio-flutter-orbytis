import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../blocs/location/location_bloc.dart';
import '../data/database.dart';
import '../models/work_order.dart';
import '../repositories/auth_repository.dart';
import '../screens/expanded_map_screen.dart';
import '../screens/history_screen.dart';
import '../screens/inspection_form_screen.dart';
import '../screens/login_screen.dart';
import '../screens/photo_viewer_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/work_orders_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter(AuthRepository repository) : _guard = SessionGuard(repository);

  final SessionGuard _guard;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/', initial: true),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: WorkOrdersRoute.page, guards: [_guard], path: '/work-orders'),
    AutoRoute(page: HistoryRoute.page, guards: [_guard], path: '/history'),
    AutoRoute(page: InspectionFormRoute.page, guards: [_guard], path: '/inspection'),
    AutoRoute(page: PhotoViewerRoute.page, guards: [_guard], path: '/photo'),
    AutoRoute(page: ExpandedMapRoute.page, guards: [_guard], path: '/map'),
  ];
}
class SessionGuard extends AutoRouteGuard {
  SessionGuard(this._repository);

  final AuthRepository _repository;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    try {
      final user = await _repository.getSession();
      if (user != null) {
        resolver.next(true);
        return;
      }
    } catch (_) {}

    resolver.next(false);
    await router.replaceAll([const LoginRoute()]);
  }
}
