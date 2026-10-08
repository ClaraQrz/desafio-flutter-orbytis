// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HistoryScreen]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HistoryScreen();
    },
  );
}

/// generated route for
/// [InspectionFormScreen]
class InspectionFormRoute extends PageRouteInfo<InspectionFormRouteArgs> {
  InspectionFormRoute({
    Key? key,
    required WorkOrder workOrder,
    List<PageRouteInfo>? children,
  }) : super(
         InspectionFormRoute.name,
         args: InspectionFormRouteArgs(key: key, workOrder: workOrder),
         initialChildren: children,
       );

  static const String name = 'InspectionFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InspectionFormRouteArgs>();
      return WrappedRoute(
        child: InspectionFormScreen(key: args.key, workOrder: args.workOrder),
      );
    },
  );
}

class InspectionFormRouteArgs {
  const InspectionFormRouteArgs({this.key, required this.workOrder});

  final Key? key;

  final WorkOrder workOrder;

  @override
  String toString() {
    return 'InspectionFormRouteArgs{key: $key, workOrder: $workOrder}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InspectionFormRouteArgs) return false;
    return key == other.key && workOrder == other.workOrder;
  }

  @override
  int get hashCode => key.hashCode ^ workOrder.hashCode;
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}

/// generated route for
/// [WorkOrdersScreen]
class WorkOrdersRoute extends PageRouteInfo<void> {
  const WorkOrdersRoute({List<PageRouteInfo>? children})
    : super(WorkOrdersRoute.name, initialChildren: children);

  static const String name = 'WorkOrdersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const WorkOrdersScreen());
    },
  );
}
