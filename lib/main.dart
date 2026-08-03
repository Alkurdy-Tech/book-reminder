import 'package:book_reminder/auth/login_screen.dart';
import 'package:book_reminder/database/app_database.dart';
import 'package:book_reminder/firebase_options.dart';
import 'package:book_reminder/notification_service.dart';
import 'package:book_reminder/screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ... your other imports

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.instance.init();

  final savedSession = await AppDatabase.instance.getSavedSession();

  // Load saved theme preference
  final savedTheme = await AppDatabase.instance.getSavedTheme();
  themeNotifier.value = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;

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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color.fromRGBO(245, 241, 234, 1), // your cream background
            primaryColor: Colors.deepOrange,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF1E1B18),
            primaryColor: Colors.deepOrange,
          ),
          home: startLoggedIn ? Screen() : LoginScreen(),
        );
      },
    );
  }
}