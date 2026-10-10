import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/location/location_bloc.dart';
import '../models/work_order.dart';
import 'location_map_card.dart';

class WorkOrderMapCard extends StatelessWidget {
  const WorkOrderMapCard({
    super.key,
    required this.workOrder,
    this.onExpand,
    this.fillHeight = false,
  });

  final WorkOrder workOrder;
  final VoidCallback? onExpand;
  final bool fillHeight;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LocationBloc>();

    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) => LocationMapCard(
        isLoading: state.isLoading,
        error: state.error,
        currentLatitude: state.currentLatitude,
        currentLongitude: state.currentLongitude,
        confirmedLatitude: state.latitude,
        confirmedLongitude: state.longitude,
        targetLatitude: workOrder.latitude,
        targetLongitude: workOrder.longitude,
        route: state.route,
        distanceMeters: state.distanceMeters,
        radiusMeters: bloc.radiusMeters,
        isInRange: state.isInRange,
        onRetry: () => bloc.add(const LocationRequested()),
        onConfirm: () => bloc.add(const LocationConfirmed()),
        onExpand: onExpand,
        fillHeight: fillHeight,
      ),
    );
  }
}