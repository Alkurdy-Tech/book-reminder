import 'package:book_reminder/auth/login_screen.dart';
import 'package:book_reminder/database/app_database.dart';
import 'package:book_reminder/firebase_options.dart';
import 'package:book_reminder/home.dart';
import 'package:book_reminder/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ... your other imports

import 'app_colors.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
final ValueNotifier<Color> accentColorNotifier = ValueNotifier(AppColors.primaryGreen); // <-- add this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.instance.init();
 
  final savedSession = await AppDatabase.instance.getSavedSession();

  final savedTheme = await AppDatabase.instance.getSavedTheme();
  themeNotifier.value = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;

  final savedColor = await AppDatabase.instance.getSavedColor(); // <-- add this
  if (savedColor != null) {
    accentColorNotifier.value = Color(savedColor);
  }

  runApp(MyApp(startLoggedIn: savedSession != null));
}

class MyApp extends StatelessWidget {
  final bool startLoggedIn;
  const MyApp({super.key, required this.startLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        
        return ValueListenableBuilder<Color>(
          valueListenable: accentColorNotifier,
          builder: (context, accentColor, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: currentMode,
              theme: ThemeData(
                brightness: Brightness.light,
                scaffoldBackgroundColor: AppColors.cream,
                primaryColor: accentColor,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: accentColor,
                  brightness: Brightness.light,
                ),
                appBarTheme: AppBarTheme(backgroundColor: accentColor),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: accentColor,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white70,
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(backgroundColor: accentColor),
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: AppColors.darkBackground,
                primaryColor: accentColor,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: accentColor,
                  brightness: Brightness.dark,
                ),
                appBarTheme: AppBarTheme(backgroundColor: accentColor),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: accentColor,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white70,
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(backgroundColor: accentColor),
                ),
              ),
              home: startLoggedIn ? homepage(): LoginScreen(),
            );
          },
        );
      },
    );
  }
}