import 'package:flutter/material.dart';
import 'package:pertemuan_2/constants/colors.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,

    // WARNA UTAMA APLIKASI
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.secondary,
    ),

    // WARNA LATAR BELAKANG
    scaffoldBackgroundColor: AppColors.background,

    // WARNA TOMBOL
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    ),
  );
}