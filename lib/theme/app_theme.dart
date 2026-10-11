import 'package:flutter/material.dart';

import '../models/inspection_status.dart';
import '../models/work_order_status.dart';

class AppColors {
  static const loginTop = Color(0xFF3C096C);
  static const loginBottom = Color(0xFF7512D2);
  static const loginCard = Color(0xFFFFFFFF);
  static const loginButton = Color(0xFF5A189A);

  static const primary = Color(0xFF7512D2);
  static const background = Color(0xFF3C096C);
  static const surface = Color(0xFFFFFFFF);

  static const draft = Color(0xFF8A8A8A);
  static const pending = Color(0xFFE8A33D);
  static const synced = Color(0xFF2E9E5B);
  static const failed = Color(0xFFD9463E);

  static const priorityHigh = Color(0xFFD9463E);
  static const priorityMedium = Color(0xFFE8A33D);
  static const priorityLow = Color(0xFF2E9E5B);

  static const navBar = Color(0xFF2A0A52);
  static const navIndicator = Color(0xFF5A189A);
  static const tabInactive = Color(0xFFF1EFF5);
}

class AppGradient {
  static const grad = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.loginTop, AppColors.loginBottom],
  );
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(50),
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

Color colorForSyncStatus(String status) {
  return switch (InspectionStatus.fromValue(status)) {
    InspectionStatus.draft => AppColors.draft,
    InspectionStatus.pending => AppColors.pending,
    InspectionStatus.synced => AppColors.synced,
    InspectionStatus.failed => AppColors.failed,
    null => AppColors.draft,
  };
}

String labelForSyncStatus(String status) {
  return switch (InspectionStatus.fromValue(status)) {
    InspectionStatus.draft => 'RASCUNHO',
    InspectionStatus.pending => 'PENDENTE',
    InspectionStatus.synced => 'SINCRONIZADO',
    InspectionStatus.failed => 'FALHOU',
    null => status.toUpperCase(),
  };
}

Color colorForWorkOrderStatus(String status) {
  return switch (WorkOrderStatus.fromValue(status)) {
    WorkOrderStatus.open => AppColors.draft,
    WorkOrderStatus.inProgress => AppColors.pending,
    WorkOrderStatus.done => AppColors.synced,
    null => AppColors.draft,
  };
}

String labelForWorkOrderStatus(String status) {
  return switch (WorkOrderStatus.fromValue(status)) {
    WorkOrderStatus.open => 'ABERTA',
    WorkOrderStatus.inProgress => 'EM ANDAMENTO',
    WorkOrderStatus.done => 'CONCLUÍDA',
    null => status.toUpperCase(),
  };
}

Color colorForPriority(String priority) {
  return switch (WorkOrderPriority.fromValue(priority)) {
    WorkOrderPriority.high => AppColors.priorityHigh,
    WorkOrderPriority.medium => AppColors.priorityMedium,
    WorkOrderPriority.low => AppColors.priorityLow,
    null => AppColors.priorityLow,
  };
}

String labelForPriority(String priority) {
  return switch (WorkOrderPriority.fromValue(priority)) {
    WorkOrderPriority.high => 'ALTA',
    WorkOrderPriority.medium => 'MÉDIA',
    WorkOrderPriority.low => 'BAIXA',
    null => priority.toUpperCase(),
  };
}
