import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF1A4570);      // --azul escuro 
  static const background = Color(0xFFF2F2F2);   // --fundo claro
  static const surface = Colors.white;

  // --status
  static const draft = Color(0xFF8A8A8A);        // --cinza
  static const pending = Color(0xFFE8A33D);      // --amarelo/âmbar
  static const synced = Color(0xFF2E9E5B);       // --verde
  static const failed = Color(0xFFD9463E);       // vermelho

  // --prioridade
  static const priorityHigh = Color(0xFFD9463E);
  static const priorityMedium = Color(0xFFE8A33D);
  static const priorityLow = Color(0xFF2E9E5B);
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

Color colorForSyncStatus(String status) {
  switch (status) {
    case 'draft':
      return AppColors.draft;
    case 'pending':
      return AppColors.pending;
    case 'synced':
      return AppColors.synced;
    case 'failed':
      return AppColors.failed;
    default:
      return AppColors.draft;
  }
}

Color colorForWorkOrderStatus(String status) {
  switch (status) {
    case 'open':
      return AppColors.draft;
    case 'in_progress':
      return AppColors.pending;
    case 'done':
      return AppColors.synced;
    default:
      return AppColors.draft;
  }
}

String labelForWorkOrderStatus(String status) {
  switch (status) {
    case 'open':
      return 'ABERTA';
    case 'in_progress':
      return 'EM ANDAMENTO';
    case 'done':
      return 'CONCLUÍDA';
    default:
      return status.toUpperCase();
  }
}

Color colorForPriority(String priority) {
  switch (priority) {
    case 'high':
      return AppColors.priorityHigh;
    case 'medium':
      return AppColors.priorityMedium;
    case 'low':
      return AppColors.priorityLow;
    default:
      return AppColors.priorityLow;
  }
}

String labelForPriority(String priority) {
  switch (priority) {
    case 'high':
      return 'ALTA';
    case 'medium':
      return 'MÉDIA';
    case 'low':
      return 'BAIXA';
    default:
      return priority.toUpperCase();
  }
}