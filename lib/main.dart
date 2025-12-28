import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:schedule_tuneup/providers/schedule_provider.dart';
import 'package:schedule_tuneup/providers/theme_provider.dart';
import 'package:schedule_tuneup/screens/home_screen.dart';
import 'package:schedule_tuneup/utils/database_helper.dart';
import 'package:schedule_tuneup/utils/app_colors.dart';

void main() async {
  // Pastikan Flutter binding sudah initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize date formatting untuk locale Indonesia dan English
  await initializeDateFormatting('id_ID', null);
  await initializeDateFormatting('en_US', null);
  
  // Initialize database
  await DatabaseHelper.instance.database;
  
  runApp(const MyKegiatanApp());
}

class MyKegiatanApp extends StatelessWidget {
  const MyKegiatanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'My Kegiatan',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorScheme: ColorScheme.light(
                primary: AppColors.primary,
                secondary: AppColors.secondary,
                surface: AppColors.surface,
                background: AppColors.whiteish,
                error: AppColors.error,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(),
              scaffoldBackgroundColor: AppColors.whiteish,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorScheme: ColorScheme.dark(
                primary: AppColors.purpleLight,
                secondary: AppColors.bluePurple,
                surface: Color(0xFF1A1A1A),
                background: AppColors.purpleDark,
                error: AppColors.error,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
              scaffoldBackgroundColor: AppColors.purpleDark,
              cardColor: Color(0xFF2A1F2D),
            ),
            themeMode: themeProvider.themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
