import 'package:material_ui/material_ui.dart';

class AppColors {
  AppColors._(); 

  static const cream = Color(0xFFFBF3EA);
  static const card = Color(0xFFFFFDF9);
  static const ink = Color(0xFF2C4A47);
  static const muted = Color(0xFF566C64);
  static const sage = Color(0xFF567A63);
  static const sectionLabel = Color(0xFF44705A);
  static const sun = Color(0xFFF9D98C);

  static const mint = Color(0xFFDCEBD3),     mintIcon = Color(0xFF3F6B4E);
  static const peach = Color(0xFFFBE2B8),    peachIcon = Color(0xFFA85F0A);
  static const lilac = Color(0xFFDAD7F2),    lilacIcon = Color(0xFF5E52AC);
  static const coral = Color(0xFFF9D6CF),    coralIcon = Color(0xFFB8432F);
  static const sky = Color(0xFFD6E7EE),      skyIcon = Color(0xFF2F6F8C);

  static const softShadow = [
    BoxShadow(color: Color(0x1F567A63), blurRadius: 12, offset: Offset(0, 4)),
  ];
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.sage, surface: AppColors.cream),
        scaffoldBackgroundColor: AppColors.cream,
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.cream,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.ink),
        ),
      );
}