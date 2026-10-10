// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ExpandedMapScreen]
class ExpandedMapRoute extends PageRouteInfo<ExpandedMapRouteArgs> {
  ExpandedMapRoute({
    Key? key,
    required WorkOrder workOrder,
    required LocationBloc locationBloc,
    List<PageRouteInfo>? children,
  }) : super(
         ExpandedMapRoute.name,
         args: ExpandedMapRouteArgs(
           key: key,
           workOrder: workOrder,
           locationBloc: locationBloc,
         ),
         initialChildren: children,
       );

  static const String name = 'ExpandedMapRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExpandedMapRouteArgs>();
      return WrappedRoute(
        child: ExpandedMapScreen(
          key: args.key,
          workOrder: args.workOrder,
          locationBloc: args.locationBloc,
        ),
      );
    },
  );
}

class ExpandedMapRouteArgs {
  const ExpandedMapRouteArgs({
    this.key,
    required this.workOrder,
    required this.locationBloc,
  });

  final Key? key;

  final WorkOrder workOrder;

  final LocationBloc locationBloc;

  @override
  String toString() {
    return 'ExpandedMapRouteArgs{key: $key, workOrder: $workOrder, locationBloc: $locationBloc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExpandedMapRouteArgs) return false;
    return key == other.key &&
        workOrder == other.workOrder &&
        locationBloc == other.locationBloc;
  }

  @override
  int get hashCode => key.hashCode ^ workOrder.hashCode ^ locationBloc.hashCode;
}

/// generated route for
/// [HistoryScreen]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HistoryScreen());
    },
  );
}

/// generated route for
/// [InspectionFormScreen]
class InspectionFormRoute extends PageRouteInfo<InspectionFormRouteArgs> {
  InspectionFormRoute({
    Key? key,
    required WorkOrder workOrder,
    Inspection? draft,
    bool readOnly = false,
    List<PageRouteInfo>? children,
  }) : super(
         InspectionFormRoute.name,
         args: InspectionFormRouteArgs(
           key: key,
           workOrder: workOrder,
           draft: draft,
           readOnly: readOnly,
         ),
         initialChildren: children,
       );

  static const String name = 'InspectionFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InspectionFormRouteArgs>();
      return WrappedRoute(
        child: InspectionFormScreen(
          key: args.key,
          workOrder: args.workOrder,
          draft: args.draft,
          readOnly: args.readOnly,
        ),
      );
    },
  );
}

class InspectionFormRouteArgs {
  const InspectionFormRouteArgs({
    this.key,
    required this.workOrder,
    this.draft,
    this.readOnly = false,
  });

  final Key? key;

  final WorkOrder workOrder;

  final Inspection? draft;

  final bool readOnly;

  @override
  String toString() {
    return 'InspectionFormRouteArgs{key: $key, workOrder: $workOrder, draft: $draft, readOnly: $readOnly}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! InspectionFormRouteArgs) return false;
    return key == other.key &&
        workOrder == other.workOrder &&
        draft == other.draft &&
        readOnly == other.readOnly;
  }

  @override
  int get hashCode =>
      key.hashCode ^ workOrder.hashCode ^ draft.hashCode ^ readOnly.hashCode;
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
/// [PhotoViewerScreen]
class PhotoViewerRoute extends PageRouteInfo<PhotoViewerRouteArgs> {
  PhotoViewerRoute({
    Key? key,
    required String path,
    List<PageRouteInfo>? children,
  }) : super(
         PhotoViewerRoute.name,
         args: PhotoViewerRouteArgs(key: key, path: path),
         initialChildren: children,
       );

  static const String name = 'PhotoViewerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PhotoViewerRouteArgs>();
      return PhotoViewerScreen(key: args.key, path: args.path);
    },
  );
}

class PhotoViewerRouteArgs {
  const PhotoViewerRouteArgs({this.key, required this.path});

  final Key? key;

  final String path;

  @override
  String toString() {
    return 'PhotoViewerRouteArgs{key: $key, path: $path}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PhotoViewerRouteArgs) return false;
    return key == other.key && path == other.path;
  }

  @override
  int get hashCode => key.hashCode ^ path.hashCode;
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
