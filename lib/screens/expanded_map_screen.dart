import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/location/location_bloc.dart';
import '../models/work_order.dart';
import '../theme/app_theme.dart';
import '../widgets/work_order_map_card.dart';

@RoutePage()
class ExpandedMapScreen extends StatelessWidget implements AutoRouteWrapper {
  const ExpandedMapScreen({
    super.key,
    required this.workOrder,
    required this.locationBloc,
  });

  final WorkOrder workOrder;
  final LocationBloc locationBloc;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(value: locationBloc, child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Localização',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: WorkOrderMapCard(workOrder: workOrder, fillHeight: true),
      ),
    );
  }
}